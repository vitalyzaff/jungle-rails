require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.sentence(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'Add produt to cart' do
    visit root_path
    expect(page).to have_text 'My Cart (0)'
    save_screenshot('add_to_cart_before.png')
    first(:button, 'Add').click
    save_screenshot('add_to_cart_after.png')
    expect(page).to have_text 'My Cart (1)'
    
  end
end