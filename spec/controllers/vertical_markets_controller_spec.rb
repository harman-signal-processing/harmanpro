require 'rails_helper'

RSpec.describe VerticalMarketsController do

  before :all do
    @vertical_market = FactoryGirl.create(:vertical_market, parent_id: 99)
    @reference_system = FactoryGirl.create(:reference_system, vertical_market: @vertical_market)
  end

  describe "GET show.html" do
    before do
      get :show, params: { id: @vertical_market.to_param }
    end

    it "assigns @vertical_market" do
      expect(assigns(:vertical_market)).to eq(@vertical_market)
    end

    it "renders show template" do
      expect(response).to render_template("show")
      expect(response).to have_http_status(:success)
    end

    it "stores page url in session" do
      expect(session["last_page"]).to eq(vertical_market_path(@vertical_market))
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
      get :show, params: { id: @vertical_market.id, format: :json }
    end

    it "assigns @vertical_market" do
      expect(assigns(:vertical_market)).to eq(@vertical_market)
    end

    it "renders json" do
      expect(response.status).to eq 200
      expect(response).to match_response_schema("vertical_market")
    end
  end
end
