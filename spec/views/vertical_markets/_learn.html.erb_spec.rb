require 'rails_helper'

RSpec.describe "vertical_markets/_learn.html.erb", :type => :view do

  before :all do
    @vertical_market = FactoryGirl.create(:vertical_market)
    @reference_system = FactoryGirl.create(:reference_system, vertical_market: @vertical_market)
    @case_study = FactoryGirl.create(:case_study, vertical_market: @vertical_market)
  end

  before :each do
    render partial: "vertical_markets/learn", locals: { vertical_market: @vertical_market }
  end

  it "shows vertical market description and headline" do
    expect(rendered).to have_css("h3", text: @vertical_market.headline)
    expect(rendered).to have_content(@vertical_market.description)
  end

  it "links to case studies" do
    #expect(rendered).to have_xpath("//img[@src='#{@case_study.banner.url(:small)}']")
    expect(rendered).to have_link(@case_study.headline, href: vertical_market_case_study_path(@vertical_market, @case_study))
  end

end
