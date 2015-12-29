require "rails_helper"

RSpec.describe "cms/available_locales/product_types/index.html.erb" do

  before :all do
    @product_type = FactoryGirl.create(:product_type)
    @locale = FactoryGirl.create(:available_locale)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:product_types, ProductType.all)
    render
  end

  it "links to edit the product type" do
    expect(rendered).to have_link(@product_type.name, href: edit_cms_available_locale_product_type_path(@locale, @product_type))
  end
end
