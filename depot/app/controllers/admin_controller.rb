class AdminController < ApplicationController
  layout 'application'
  def index
    @total_orders = Order.count
  end
end
