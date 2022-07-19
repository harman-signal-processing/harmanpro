require "rails_helper"

RSpec.describe "cms/available_locales/events/_form" do

  before :all do
    @locale = FactoryBot.create(:available_locale)
    @event = FactoryBot.create(:event)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:event, @event)
    render
  end

  it "has the fields" do
    expect(rendered).to have_field 'Name'
    expect(rendered).to have_field 'Description'
    expect(rendered).to have_field 'Page content'
    expect(rendered).to have_button "Save Changes"
  end

end
