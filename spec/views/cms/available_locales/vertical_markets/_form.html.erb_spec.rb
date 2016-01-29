require "rails_helper"

RSpec.describe "cms/available_locales/vertical_markets/_form.html.erb" do

  before :all do
    @locale = FactoryGirl.create(:available_locale)
    @vertical_market = FactoryGirl.create(:vertical_market)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:vertical_market, @vertical_market)
    render
  end

  it "has the fields" do
    expect(rendered).to have_field 'Name'
    expect(rendered).to have_field 'Description'
    expect(rendered).to have_field "Headline"
    expect(rendered).to have_button "Save Changes"
  end

end
