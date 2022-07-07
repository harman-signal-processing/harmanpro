require "rails_helper"

RSpec.describe "events/recent", as: :view do

  before :all do
    @past_event = FactoryBot.create(:event,
                                      start_on: 2.weeks.ago,
                                      end_on: 1.week.ago,
                                      active: true)
  end

  before do
    assign(:events, Event.recent)
    render
  end

  it "has event title" do
    expect(rendered).to have_content @past_event.name
  end

end
