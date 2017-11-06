require "rails_helper"

RSpec.describe "cms/available_locales/venues/index.html.erb" do

  before :all do
    @venue = FactoryBot.create(:venue)
    @locale = FactoryBot.create(:available_locale)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:venues, Venue.all)
    render
  end

  it "links to edit the venue" do
    expect(rendered).to have_link(@venue.name, href: edit_cms_available_locale_venue_path(@locale, @venue))
  end
end
