require 'rails_helper'

RSpec.describe "shared/_learn_plan_buy_nav.html.erb", :type => :view do

  before do
    render partial: "shared/learn_plan_buy_nav"
  end

  it "should have links to Learn, Plan, Buy" do
    expect(rendered).to have_link "Learn"
    expect(rendered).to have_link "Plan"
    expect(rendered).to have_link "Buy"
  end

  context "magellan (zurb foundation)" do
    it "should have magellan expedition container" do
      expect(rendered).to have_xpath("//div[@data-magellan-expedition='fixed']")
    end

    it "should have magellan arrival links" do
      expect(rendered).to have_xpath("//dd[@data-magellan-arrival='learn']")
      expect(rendered).to have_xpath("//dd[@data-magellan-arrival='plan']")
      expect(rendered).to have_xpath("//dd[@data-magellan-arrival='buy']")
    end

    it "should have destination for the learn section" do
      expect(rendered).to have_xpath("//a[@data-magellan-destination='learn']")
    end
  end
end
