require 'rails_helper'

RSpec.describe "vertical_markets/_buy", :type => :view do

  before :all do
    current_locale = FactoryBot.create(:available_locale, key: I18n.default_locale)
    @help_me_get_started = FactoryBot.create(:site_setting, name: "button-help-me-get-started", content: "Help Me Get Started")
    FactoryBot.create(:site_setting, name: 'store_link', content: 'http://shop.harmanpro.com')
    FactoryBot.create(:site_setting, name: 'buy_direct_from_harman_headline', content: 'Buy Direct From Us')
    FactoryBot.create(:site_setting, name: "buy_from_online_retailer_headline", content: "Buy From A Retailer")
    FactoryBot.create(:site_setting, name: "installed-buy-headline", content: "AV System Design")
    FactoryBot.create(:site_setting, name: "installed-buy-paragraph", content: "In 8 Easy Steps")
    @retailer = FactoryBot.create(:online_retailer)
    current_locale.online_retailers << @retailer
    @vertical_market = FactoryBot.create(:vertical_market)
    @reference_system = FactoryBot.create(:reference_system, vertical_market: @vertical_market)
    @lead = Lead.new(vertical_market: @vertical_market)
  end

  context "retail" do
    before do
      @vertical_market.update_column(:retail, true)
      assign(:lead, @lead)
      render partial: "vertical_markets/buy", locals: { vertical_market: @vertical_market }
    end

    it "links to ecommerce store" do
      expect(rendered).to have_content("Buy Direct From Us")
      expect(rendered).to have_css("a[@href='http://shop.harmanpro.com']")
    end

    it "links to online retailers" do
      expect(rendered).to have_content("Buy From A Retailer")
      expect(rendered).to have_link(@retailer.name, href: @retailer.url)
      expect(rendered).to match @retailer.logo.url(:medium)
    end

    it "won't have installed audio buy section" do
      expect(rendered).not_to have_content("AV System Design")
      expect(rendered).not_to have_content("In 8 Easy Steps")
    end
  end

end
