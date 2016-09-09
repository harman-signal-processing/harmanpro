require 'rails_helper'

RSpec.describe "main/index.html.erb", as: :view do
  before(:all) do
    @brands = FactoryGirl.create_list(:brand, 3)
    @vertical_markets = FactoryGirl.create_list(:vertical_market, 3, parent_id: nil)
    @slides = FactoryGirl.create_list(:slide, 2)
    @case_studies = FactoryGirl.create_list(:case_study, 4)
    @media_library_page = FactoryGirl.create(:landing_page)

    assign(:vertical_markets, @vertical_markets)
    assign(:slides, @slides)
    assign(:featured_case_studies, @case_studies)
    assign(:media_library_page, @media_library_page)
  end

  before :each do
    allow(view).to receive(:all_brands).and_return(@brands)

    render
  end

  it "links to all top-level vertical markets" do
    @vertical_markets.each do |vm|
      expect(rendered).to have_link(vm.name, href: vertical_market_path(vm))
    end
  end

end
