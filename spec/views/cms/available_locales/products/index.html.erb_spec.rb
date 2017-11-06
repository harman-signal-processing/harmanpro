require "rails_helper"

RSpec.describe "cms/available_locales/products/index.html.erb" do

  before :all do
    @product = FactoryBot.create(:product)
    @locale = FactoryBot.create(:available_locale)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:products, Product.all)
    render
  end

  it "links to edit the product" do
    expect(rendered).to have_link(@product.name, href: edit_cms_available_locale_product_path(@locale, @product))
  end
end
