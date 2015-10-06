require "rails_helper"

RSpec.describe "events/index.html.erb", as: :view do

  before :all do
    @future_event = FactoryGirl.create(:event, start_on: 4.weeks.from_now, end_on: 5.weeks.from_now, active: true)
    @current_event = FactoryGirl.create(:event,
                                        start_on: 2.days.ago,
                                        end_on: 2.days.from_now,
                                        featured: true,
                                        image: File.new(Rails.root.join('spec','fixtures','test.jpg')),
                                        active: true)
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
    expect(rendered).to have_link @current_event.name, href: event_path(@current_event)
    expect(rendered).to have_xpath("//img[@src='#{ @current_event.image.url(:medium) }']")
  end
end
