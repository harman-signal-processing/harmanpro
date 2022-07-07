require 'rails_helper'

RSpec.describe "main/index", as: :view do
  before(:all) do
    @brands = FactoryBot.create_list(:brand, 3)
    @vertical_markets = FactoryBot.create_list(:vertical_market, 3, parent_id: nil)
    @slides = FactoryBot.create_list(:slide, 2)
    @case_studies = FactoryBot.create_list(:case_study, 4)

    assign(:vertical_markets, @vertical_markets)
    assign(:slides, @slides)
    assign(:featured_case_studies, @case_studies)
  end

  before :each do
    allow(view).to receive(:all_brands).and_return(@brands)

    render
  end

  # Nope, it doesn't do this anymore
  #it "links to all top-level vertical markets" do
  #  @vertical_markets.each do |vm|
  #    expect(rendered).to have_link(vm.name, href: vertical_market_path(vm))
  #  end
  #end

end
