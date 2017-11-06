require 'rails_helper'

RSpec.describe Event, type: :model do

  before :all do
    @future_event = FactoryBot.create(:event, start_on: 4.weeks.from_now, end_on: 5.weeks.from_now, active: true)
    @current_event = FactoryBot.create(:event, start_on: 2.days.ago, end_on: 2.days.from_now, featured: true, active: true)
    @past_event = FactoryBot.create(:event, start_on: 5.weeks.ago, end_on: 4.weeks.ago, active: true)
    @hidden_event = FactoryBot.create(:event, active: false)
  end

  subject { @current_event }
  it { should respond_to(:name) }
  it { should respond_to(:start_on) }
  it { should respond_to(:end_on) }
  it { should respond_to(:image) }
  it { should respond_to(:friendly_id) }
  it { should respond_to(:page_content) }
  it { should respond_to(:more_info_link) }
  it { should respond_to(:new_window) }

  describe ".current_and_upcoming" do
    before do
      @current_and_upcoming = Event.current_and_upcoming
    end

    it "should include future events" do
      expect(@current_and_upcoming).to include(@future_event)
    end

    it "should include events currently happening" do
      expect(@current_and_upcoming).to include(@current_event)
    end

    it "should not include hidden events" do
      expect(@current_and_upcoming).not_to include(@hidden_event)
    end
  end

  describe ".recent" do
    before do
      @very_old_event = FactoryBot.create(:event, start_on: 5.years.ago, end_on: 5.years.ago)
      @recent = Event.recent
    end

    it "includes recently past events" do
      expect(@recent).to include(@past_event)
    end

    it "won't include very old events" do
      expect(@recent).not_to include(@very_old_event)
    end
  end

end
