require "rails_helper"

RSpec.describe "cms/available_locales/brands/_form" do

  before :all do
    @locale = FactoryBot.create(:available_locale)
    @brand = FactoryBot.create(:brand)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:brand, @brand)
    render
  end

  it "has the fields" do
    expect(rendered).to have_field "Description"
    expect(rendered).to have_field "Contact info for consultants"
    expect(rendered).to have_button "Save Changes"
  end
end
