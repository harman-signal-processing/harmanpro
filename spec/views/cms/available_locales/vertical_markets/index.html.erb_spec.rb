require "rails_helper"

RSpec.describe "cms/available_locales/vertical_markets/index.html.erb" do

  before :all do
    @vertical_market = FactoryBot.create(:vertical_market)
    @locale = FactoryBot.create(:available_locale)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:vertical_markets, VerticalMarket.all)
    render
  end

  it "links to edit the vertical market" do
    expect(rendered).to have_link(@vertical_market.name, href: edit_cms_available_locale_vertical_market_path(@locale, @vertical_market))
  end
end
