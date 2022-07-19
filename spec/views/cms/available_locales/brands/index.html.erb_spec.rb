require "rails_helper"

RSpec.describe "cms/available_locales/brands/index" do

  before :all do
    @brand = FactoryBot.create(:brand)
    @locale = FactoryBot.create(:available_locale)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:brands, Brand.all)
    render
  end

  it "links to edit brand" do
    expect(rendered).to have_link(@brand.name, href: edit_cms_available_locale_brand_path(@locale, @brand))
  end
end
