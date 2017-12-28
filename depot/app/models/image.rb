class Image < ApplicationRecord
  attr_accessor :uploaded_file

  # constants
  DEFAULT_UPLOAD_PATH = Rails.root.join('public', 'images')

  # validations
  validates_with ImageCountValidator

  # callbacks
  before_save :set_image_details
  before_create :create_directory_if_not_exist

  after_save :save_image
  after_destroy :delete_respective_image

  after_rollback :remove_directory_if_empty

  # associations
  belongs_to :product

  def set_image_details
    self.filename = image.original_filename
    self.filepath = "#{product_id}/".concat(filename)
  end

  def create_directory_if_not_exist
    Dir.mkdir(get_directory_path_for_product) unless File.directory?(get_directory_path_for_product)
  end

  def save_image
    path = get_directory_path_for_product.join(image.original_filename)
    File.open(DEFAULT_UPLOAD_PATH.join(path), 'wb') do |file|
      file.write(image.read)
    end
  end

  private

    def get_directory_path_for_product
      DEFAULT_UPLOAD_PATH.join(product_id.to_s)
    end

    def image
      uploaded_file[:image]
    end

    def remove_directory_if_empty
      Dir.rmdir(get_directory_path_for_product) if Dir.empty?(get_directory_path_for_product)
    end

    def delete_respective_image
      File.delete(DEFAULT_UPLOAD_PATH.join(filepath)) if File.exist?(DEFAULT_UPLOAD_PATH.join(filepath))
      remove_directory_if_empty
    end
end
