class Admin::DashboardController < ApplicationController
  def show
    @products = Product.all
    @products_number = Product.count
    @categories_number = Category.count
  end

  def index
    @products = Product.all
  end
end
