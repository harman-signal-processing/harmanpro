require "rails_helper"

RSpec.describe "cms/available_locales/vertical_markets/_form" do

  before :all do
    @locale = FactoryBot.create(:available_locale)
    @vertical_market = FactoryBot.create(:vertical_market)
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
