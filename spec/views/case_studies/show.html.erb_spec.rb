require 'rails_helper'

RSpec.describe "case_studies/show", :type => :view do

  before :all do
    csvm = FactoryBot.create(:case_study_vertical_market)
    @vertical_market = csvm.vertical_market
    @case_study = csvm.case_study

    assign(:case_study, @case_study)
    assign(:vertical_market, @vertical_market)
  end

  before :each do
    render
  end

  it "displays the headline" do
    expect(rendered).to have_css("h1", text: @case_study.headline)
  end

  it "displays the body content" do
    expect(rendered).to have_content(@case_study.content)
  end

  it "displays the banner image" do
    expect(rendered).to match @case_study.banner.url(:large)
  end

end

