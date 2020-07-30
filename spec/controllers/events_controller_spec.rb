require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  before :all do
    @future_event = FactoryBot.create(:event, start_on: 4.weeks.from_now, end_on: 5.weeks.from_now, active: true)
    @current_event = FactoryBot.create(:event, start_on: 2.days.ago, end_on: 2.days.from_now, featured: true, active: true)
    @past_event = FactoryBot.create(:event, start_on: 5.weeks.ago, end_on: 4.weeks.ago, active: true)
    @hidden_event = FactoryBot.create(:event, active: false)
  end

  describe "GET index" do
    before do
      get :index
    end

    it "should render the template" do
      expect(response).to render_template('index')
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do

    it "should redirect to index for hidden event" do
      get :show, params: { id: @hidden_event.to_param }

      expect(response).to redirect_to(events_path)
    end
  end

  describe "GET recent" do

    before do
      get :recent
    end

    it "should render the template" do
      expect(response).to render_template("recent")
    end

  end

end
