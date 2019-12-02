require 'rails_helper'

feature "Exits to brand sites via brand page" do

  before :all do
    rsptp = FactoryBot.create(:reference_system_product_type_product)
    @product = rsptp.product
    @brand = @product.brand
    @reference_system_product_type = rsptp.reference_system_product_type
    @product_type = @reference_system_product_type.product_type
    @reference_system = @reference_system_product_type.reference_system
    @vertical_market = @reference_system.vertical_market
    @vertical_market.update_column(:retail, true)
  end

  scenario "via reference system products list" do
    visit vertical_market_reference_system_path(@vertical_market, @reference_system)

    click_on @product_type.name

    expect(page).to have_link(@product.name, href: @product.url)
  end

  scenario "via brand page" do
    visit brand_path(@brand)

    expect(page).to have_link(@brand.friendly_url, href: @brand.url)
  end
end
