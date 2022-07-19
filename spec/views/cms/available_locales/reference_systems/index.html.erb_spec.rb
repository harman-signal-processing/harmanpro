require "rails_helper"

RSpec.describe "cms/available_locales/reference_systems/index" do

  before :all do
    @reference_system = FactoryBot.create(:reference_system)
    @locale = FactoryBot.create(:available_locale)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:reference_systems, ReferenceSystem.all)
    render
  end

  it "links to edit the reference system" do
    expect(rendered).to have_link(@reference_system.name, href: edit_cms_available_locale_reference_system_path(@locale, @reference_system))
  end
end
