require "rails_helper"

RSpec.describe VenuesController, as: :controller do

  describe "GET index.json" do
    before do
      @venue = FactoryBot.create(:venue)
      get :index, params: { format: :json }
    end

    it "assigns @venues collection" do
      expect(assigns(:venues).first).to eq(@venue)
    end

    it "renders json" do
      expect(response.status).to eq 200
      expect(response).to match_response_schema("venues")
    end
  end

end
