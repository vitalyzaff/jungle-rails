class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']
  def show
    @products = Product.all
    @products_number = Product.count
    @categories_number = Category.count
  end

  def index
    @products = Product.all
  end
end
