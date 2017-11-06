require 'rails_helper'

RSpec.describe ApplicationHelper do

  describe "#top_vertical_market_navigation" do
    before do
      @vertical_markets = FactoryBot.create_list(:vertical_market, 3)
      @child_vertical = FactoryBot.create(:vertical_market, parent_id: @vertical_markets.first.id)
    end

    it "no longer links to each top-level vertical market" do
      @vertical_markets.each do |vm|
        nav = helper.top_vertical_market_navigation(dropdowns: false)
        expect(nav).not_to have_link(vm.name, href: vertical_market_path(vm))
      end
    end

  end

  describe "#current_locale" do
    it "retrieves the current AvailableLocale from the I18n.locale" do
      espanish = FactoryBot.create(:available_locale, key: "es")
      I18n.locale = espanish.key

      loc = helper.current_locale

      expect(loc).to eq espanish
      I18n.locale = I18n.default_locale
    end
  end

end
