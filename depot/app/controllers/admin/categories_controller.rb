class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.all
  end

  def products
    @category = Category.includes(:sub_category_products).find(params[:id])
  end
end
