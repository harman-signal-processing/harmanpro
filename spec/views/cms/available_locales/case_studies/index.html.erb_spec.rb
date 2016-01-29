require "rails_helper"

RSpec.describe "cms/available_locales/case_studies/index.html.erb" do

  before :all do
    @case_study = FactoryGirl.create(:case_study)
    @locale = FactoryGirl.create(:available_locale)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:case_studies, CaseStudy.all)
    render
  end

  it "links to edit the case study" do
    expect(rendered).to have_link(@case_study.headline, href: edit_cms_available_locale_case_study_path(@locale, @case_study))
  end
end
