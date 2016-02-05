require "rails_helper"

RSpec.describe "cms/available_locales/events/_form.html.erb" do

  before :all do
    @locale = FactoryGirl.create(:available_locale)
    @event = FactoryGirl.create(:event)
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
