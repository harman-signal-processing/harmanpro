require "rails_helper"

RSpec.describe "cms/available_locales/case_studies/_form.html.erb" do

  before :all do
    @locale = FactoryBot.create(:available_locale)
    @case_study = FactoryBot.create(:case_study)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:case_study, @case_study)
    render
  end

  it "has the fields" do
    expect(rendered).to have_field 'Headline'
    expect(rendered).to have_field 'Description'
    expect(rendered).to have_field 'Content'
    expect(rendered).to have_button "Save Changes"
  end

end
