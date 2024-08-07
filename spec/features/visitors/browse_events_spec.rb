require "rails_helper"

feature "Browse events" do

  before :all do
    @future_event = FactoryBot.create(:event, start_on: 4.weeks.from_now, end_on: 5.weeks.from_now, active: true)
    @current_event = FactoryBot.create(:event, start_on: 2.days.ago, end_on: 2.days.from_now, featured: true, active: true)
    @past_event = FactoryBot.create(:event, start_on: 5.weeks.ago, end_on: 4.weeks.ago, active: true)
    @hidden_event = FactoryBot.create(:event, active: false)
    unless SiteSetting.set?(:show_events)
      FactoryBot.create(:site_setting, name: "show_events")
    end
  end

  before :each do
    # 2024-07 Events no longer appears in nav. Test by accessing events index directly
    visit events_path
  end

  scenario "browsing events, lists current and upcoming events" do
    expect(page).to have_content @current_event.name
    expect(page).to have_content @future_event.name
    expect(page).to have_content @future_event.description
    expect(page).not_to have_content @past_event.name
    expect(current_path).to eq(events_path)
  end

  scenario "featured events have picture, link to detail page" do
    expect(page).to have_link @current_event.name, href: event_path(@current_event)
  end

  scenario "hidden events do not appear" do
    expect(page).not_to have_content(@hidden_event.name)
  end

  scenario "past events are navigable directly with the url" do
    visit event_path(@past_event)

    expect(page).to have_content @past_event.name
    expect(page).to have_content @past_event.description
    expect(current_path).to eq(event_path(@past_event))
  end

  scenario "recent events page lists past events" do
    click_on "recent events"

    expect(page).to have_content @past_event.name
    expect(current_path).to eq(recent_events_path)
  end
end
