require "rails_helper"

feature "Sitemap" do

  before :all do
    @brand = FactoryBot.create(:brand)
    csvm = FactoryBot.create(:case_study_vertical_market)
    @vertical_market = csvm.vertical_market
    @case_study = csvm.case_study
    @reference_system = FactoryBot.create(:reference_system, vertical_market: @vertical_market)
  end

  context "XML output" do
    before do
      visit sitemap_path(format: 'xml')
    end

    scenario "links to brand page" do
      expect(page).to have_selector("loc", text: brand_path(@brand))
    end

    scenario "links to vertical market page" do
      expect(page).to have_selector("loc", text: vertical_market_path(@vertical_market))
    end

    scenario "links to reference system page" do
      expect(page).to have_selector("loc", text: vertical_market_reference_system_path(@vertical_market, @reference_system))
    end

    scenario "links to case study page" do
      expect(page).to have_selector("loc", text: case_study_path(@case_study))
    end
  end

  context "HTML output" do
    before do
      visit sitemap_path(format: 'html')
    end

    scenario "it links to brand page" do
      expect(page).to have_link(@brand.name, href: brand_path(@brand))
    end

    scenario "links to vertical market page" do
      expect(page).to have_link(@vertical_market.name, href: vertical_market_path(@vertical_market))
    end

    scenario "links to reference system page" do
      expect(page).to have_link(@reference_system.name, href: vertical_market_reference_system_path(@vertical_market, @reference_system))
    end

    scenario "links to case study page" do
      expect(page).to have_link(@case_study.headline, href: case_study_path(@case_study))
    end
  end

end
