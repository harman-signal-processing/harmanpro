require "rails_helper"

RSpec.describe "CMS Routes" do

  before :all do
    @locale = FactoryBot.create(:available_locale, key: 'es')
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  it "routes to CMS root" do
    expect(get: "/cms").to route_to(
      controller: "cms",
      action: "index"
    )
  end

  it "routes to CMS locale root" do
    expect(get: "/cms/available_locales/#{ @locale.key }").to route_to(
      controller: "cms/available_locales",
      action: "show",
      id: @locale.to_param
    )
  end

  it "routes translatables" do
    expect(get: "/cms/available_locales/#{ @locale.key }/brands").to route_to(
      controller: "cms/brands",
      action: "index",
      available_locale_id: @locale.to_param
    )
  end

  it "routes translatable item" do
    brand = FactoryBot.create(:brand)
    expect(get: "/cms/available_locales/#{ @locale.key }/brands/#{ brand.to_param }").to route_to(
      controller: "cms/brands",
      action: "show",
      available_locale_id: @locale.to_param,
      id: brand.to_param
    )
  end

  it "routes custom menus for locale" do
    expect(get: "/cms/available_locales/#{ @locale.key }/menu_items").to route_to(
      controller: "cms/menu_items",
      action: "index",
      available_locale_id: @locale.to_param
    )
  end

end
