require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save to db if all fields are valid' do
      @category = Category.new(name: 'Test')
      @product = Product.new(name: 'Test Product', price: 25, quantity: 5, category: @category)
      @product.save
      expect(@product).to be_valid
    end

    it 'should NOT save to db if name field is NOT valid' do
      @category = Category.new(name: 'Test')
      @product = Product.new(name: nil, price: 25, quantity: 5, category: @category)
      @product.save
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it 'should NOT save to db if price field is NOT valid' do
      @category = Category.new(name: 'Test')
      @product = Product.new(name: 'Test Product', price: nil, quantity: 5, category: @category)
      @product.save
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it 'should NOT save to db if quantity field is NOT valid' do
      @category = Category.new(name: 'Test')
      @product = Product.new(name: 'Test Product', price: 25, quantity: nil, category: @category)
      @product.save
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it 'should NOT save to db if quantity field is NOT valid' do
      @category = Category.new(name: 'Test')
      @product = Product.new(name: 'Test Product', price: 25, quantity: 5, category: nil)
      @product.save
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end


  end
end