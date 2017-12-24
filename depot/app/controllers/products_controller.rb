class ProductsController < ApplicationController
  DEFAULT_UPLOAD_PATH = Rails.root.join('public', 'images')

  before_action :set_product, only: [:show, :edit, :update, :destroy]
  after_action :handle_uploaded_images, only: [:create, :update]
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    respond_to do |format|
      format.html
      format.json { render json: @products, only: :title, include: { category: { only: :name } } }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    3.times { @product.images.build }
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product.images.destroy
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
        @products = Product.all
        ActionCable.server.broadcast 'products',
          html: render_to_string('store/index', layout: false)
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    if @product.destroy
      respond_to do |format|
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render :show, error: @product.errors.full_messages }
        format.json { render json: { errors: @product.errors.full_messages }, status: 422 }
      end
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :discount_price, :enabled, :permalink, :category_id,
        images_attributes: [:id, :image_name]
      )
    end

    def create_directory_if_not_exist
      Dir.mkdir(DEFAULT_UPLOAD_PATH) unless File.directory?(DEFAULT_UPLOAD_PATH)
    end

    def handle_uploaded_images
      if @product.valid?
        create_directory_if_not_exist
        product_params[:images_attributes].each_pair do |_, value|
          if value.key?(:image_name)
            save_to_images(value[:image_name])
          end
        end
      end
    end

    def save_to_images(image_object)
      File.open(DEFAULT_UPLOAD_PATH.join(image_object.original_filename), 'wb') do |file|
        file.write(image_object.read)
      end
    end
end
