require 'rails_helper'

RSpec.describe LandingPagesController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      landing_page = FactoryBot.create(:landing_page)

      get :show, params: { id: landing_page.to_param }

      expect(assigns(:landing_page)).to eq landing_page
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET thankyou" do
    it "renders thankyou template" do
      get :thankyou

      expect(response).to render_template("thankyou")
    end
  end

  describe "GET thanks" do
    it "renders generic thanks template" do
      get :thanks

      expect(response).to render_template("thanks")
    end
  end

end
