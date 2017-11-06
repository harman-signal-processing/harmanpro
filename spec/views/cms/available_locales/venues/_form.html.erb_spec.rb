require "rails_helper"

RSpec.describe "cms/available_locales/venues/_form.html.erb" do

  before :all do
    @locale = FactoryBot.create(:available_locale)
    @venue = FactoryBot.create(:venue)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:venue, @venue)
    render
  end

  it "has the fields" do
    expect(rendered).to have_field 'Name'
    expect(rendered).to have_field 'Description'
    expect(rendered).to have_button "Save Changes"
  end

end
