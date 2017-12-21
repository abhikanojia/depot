class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:sub_categories).root_categories
  end
end
