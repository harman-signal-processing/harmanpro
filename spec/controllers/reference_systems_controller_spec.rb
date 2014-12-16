require 'rails_helper'

RSpec.describe ReferenceSystemsController, :type => :controller do

  before do
    @vertical_market = FactoryGirl.create(:vertical_market)
    @reference_system = FactoryGirl.create(:reference_system, vertical_market: @vertical_market)
  end

  describe "GET show.html" do
    before do
      get :show, id: @reference_system.id, vertical_market_id: @vertical_market.id
    end

    it "assigns @reference_system" do
      expect(assigns(:reference_system)).to eq(@reference_system)
    end

    it "assigns @vertical_market" do
      expect(assigns(:vertical_market)).to eq(@vertical_market)
    end

    it "renders show template" do
      expect(response).to render_template("show")
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show.json" do
    before do
      product_type = FactoryGirl.create(:product_type)
      rspt = FactoryGirl.create(:reference_system_product_type,
                                reference_system: @reference_system,
                                product_type: product_type)
      FactoryGirl.create(:reference_system_product_type_product,
                         reference_system_product_type: rspt)
      get :show, id: @reference_system.id, vertical_market_id: @vertical_market.id, format: :json
    end

    it "assigns @reference_system" do
      expect(assigns(:reference_system)).to eq(@reference_system)
    end

    it "renders json" do
      expect(response.status).to eq 200
      expect(response).to match_response_schema("reference_system")
    end
  end
end
