require "rails_helper"

feature "Visitor exits to a retailer" do

  before :all do
    current_locale = FactoryBot.create(:available_locale, key: I18n.default_locale)
    @vertical_market = FactoryBot.create(:vertical_market, retail: true)
    @reference_system = FactoryBot.create(:reference_system, vertical_market: @vertical_market)
    @retailer = FactoryBot.create(:online_retailer)
    @store_link = FactoryBot.create(:site_setting, name: 'store_link', content: "http://store.lvh.me")
    current_locale.online_retailers << @retailer
  end

  before :each do
    visit vertical_market_path(@vertical_market)
  end

  scenario "harmanpro online store" do
    click_on "Shop Now"

    expect(current_url).to match(@store_link.content)
  end

  scenario "3rd party online retailer" do
    click_on @retailer.name

    expect(current_url).to match(@retailer.url)
  end
end
