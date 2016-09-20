require "rails_helper"

RSpec.describe "main/sitemap.html.erb", as: :view do

  before :all do
    @brand = FactoryGirl.create(:brand)
    @vertical_market = FactoryGirl.create(:vertical_market)
    @reference_system = FactoryGirl.create(:reference_system, vertical_market: @vertical_market)
    csvm = FactoryGirl.create(:case_study_vertical_market, vertical_market: @vertical_market)
    @case_study = csvm.case_study

    assign(:vertical_markets, [@vertical_market])
  end

  before :each do
    allow(view).to receive(:all_brands).and_return([@brand])
    render
  end

  it "links to brand" do
    expect(rendered).to have_link(@brand.name, href: brand_path(@brand))
  end

  it "links to vertical market" do
    expect(rendered).to have_link(@vertical_market.name, href: vertical_market_path(@vertical_market))
  end

  it "links to reference system" do
    expect(rendered).to have_link(@reference_system.name, href: vertical_market_reference_system_path(@vertical_market, @reference_system))
  end

  it "links to case studies" do
    expect(rendered).to have_link(@case_study.headline, href: case_study_path(@case_study))
  end
end
