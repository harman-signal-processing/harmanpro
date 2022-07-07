require "rails_helper"

RSpec.describe "cms/available_locales/show" do

  before :all do
    @locale = FactoryBot.create(:available_locale)
  end

  before :each do
    assign(:available_locale, @locale)
    render
  end

  it "lists categories of items to be translated in a side nav" do
    AvailableLocale.translatables.each do |t|
      expect(rendered).to have_link t.underscore.humanize.pluralize.titleize
    end
  end

end
