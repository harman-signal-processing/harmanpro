require "rails_helper"

RSpec.describe "cms/available_locales/landing_pages/_form.html.erb" do

  before :all do
    @locale = FactoryBot.create(:available_locale)
    @landing_page = FactoryBot.create(:landing_page)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:landing_page, @landing_page)
    render
  end

  it "has the fields" do
    expect(rendered).to have_field 'Title'
    expect(rendered).to have_field 'Subtitle'
    expect(rendered).to have_field 'Description'
    expect(rendered).to have_field 'Main content'
    expect(rendered).to have_field 'Left content'
    expect(rendered).to have_field 'Right content'
    expect(rendered).to have_field 'Sub content'
    expect(rendered).to have_button "Save Changes"
  end

end
