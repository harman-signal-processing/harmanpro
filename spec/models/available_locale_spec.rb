require 'rails_helper'

RSpec.describe AvailableLocale, type: :model do

  before :all do
    @loc = FactoryBot.create(:available_locale)
  end

  subject { @loc }
  it { should respond_to :name }
  it { should respond_to :key }
  it { should respond_to :translators }
  it { should respond_to :items_to_translate }

  it "collects items_to_translate" do
    vertical_market = FactoryBot.create(:vertical_market)
    reference_system = FactoryBot.create(:reference_system)
    brand = FactoryBot.create(:brand)
    case_study = FactoryBot.create(:case_study)
    landing_page = FactoryBot.create(:landing_page)
    product_type = FactoryBot.create(:product_type)
    product = FactoryBot.create(:product)
    site_setting = FactoryBot.create(:site_setting)

    expect(@loc.items_to_translate).to include(vertical_market)
    expect(@loc.items_to_translate).to include(reference_system)
    expect(@loc.items_to_translate).to include(brand)
    expect(@loc.items_to_translate).to include(case_study)
    expect(@loc.items_to_translate).to include(landing_page)
    expect(@loc.items_to_translate).to include(product_type)
    expect(@loc.items_to_translate).to include(product)
    expect(@loc.items_to_translate).to include(site_setting)
  end

  it "has custom menu items" do
    menu_item = FactoryBot.create(:menu_item,
                                   locale: @loc,
                                   title: "Tienda",
                                   link: "http://shop.harmanpro.com",
                                   enabled: true,
                                   new_tab: true)
    expect(@loc.menu_items).to include(menu_item)
  end
end
