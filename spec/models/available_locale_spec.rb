require 'rails_helper'

RSpec.describe AvailableLocale, type: :model do

  before :all do
    @loc = FactoryBot.build(:available_locale)
  end

  subject { @loc }
  it { should respond_to :name }
  it { should respond_to :key }
  it { should respond_to :translators }
  it { should respond_to :items_to_translate }

  it "collects items_to_translate" do
    vertical_market = FactoryBot.build(:vertical_market)
    allow(VerticalMarket).to receive(:needing_translations).with(@loc.key).and_return(vertical_market)

    brand = FactoryBot.build(:brand)
    allow(Brand).to receive(:needing_translations).with(@loc.key).and_return(brand)

    case_study = FactoryBot.build(:case_study)
    allow(CaseStudy).to receive(:needing_translations).with(@loc.key).and_return(case_study)

    landing_page = FactoryBot.build(:landing_page)
    allow(LandingPage).to receive(:needing_translations).with(@loc.key).and_return(landing_page)

    product = FactoryBot.build(:product)
    allow(Product).to receive(:needing_translations).with(@loc.key).and_return(product)

    site_setting = FactoryBot.build(:site_setting)
    allow(SiteSetting).to receive(:needing_translations).with(@loc.key).and_return(site_setting)

    items_to_translate = @loc.items_to_translate

    expect(items_to_translate).to include(vertical_market)
    expect(items_to_translate).to include(brand)
    expect(items_to_translate).to include(case_study)
    expect(items_to_translate).to include(landing_page)
    expect(items_to_translate).to include(product)
    expect(items_to_translate).to include(site_setting)
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
