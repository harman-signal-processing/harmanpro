require "rails_helper"

RSpec.describe "cms/available_locales/events/index" do

  before :all do
    @event = FactoryBot.create(:event)
    @locale = FactoryBot.create(:available_locale)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:events, Event.all)
    render
  end

  it "links to edit the event" do
    expect(rendered).to have_link(@event.name, href: edit_cms_available_locale_event_path(@locale, @event))
  end
end
