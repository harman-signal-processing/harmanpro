require "rails_helper"

RSpec.describe "events/index.html.erb", as: :view do

  before :all do
    @future_event = FactoryGirl.create(:event, start_on: 4.weeks.from_now, end_on: 5.weeks.from_now, active: true)
    @current_event = FactoryGirl.create(:event,
                                        start_on: 2.days.ago,
                                        end_on: 2.days.from_now,
                                        featured: true,
                                        more_info_link: 'http://foo.com',
                                        new_window: true,
                                        image: File.new(Rails.root.join('spec','fixtures','test.jpg')),
                                        active: true)
    # so the 'recent events' button appears
    FactoryGirl.create(:event, start_on: 3.weeks.ago, end_on: 2.weeks.ago, active: true)
  end

  before do
    assign(:events, Event.current_and_upcoming)
    render
  end

  it "has event content" do
    expect(rendered).to have_content @future_event.name
    expect(rendered).to have_content @future_event.description
    expect(rendered).to have_content @current_event.name
    expect(rendered).to have_content @current_event.description
  end

  it "has featured event content" do
    expect(rendered).to have_link @current_event.name, href: @current_event.more_info_link
    expect(rendered).to match @current_event.image.url(:medium)
  end

  it "has a link to recent events" do
    expect(rendered).to have_link "recent events", href: recent_events_path
  end
end
