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

  describe "GET privacy_policy" do
    it "responds with privacy policy page" do
      privacy_policy = FactoryBot.create(:landing_page)
      expect(LandingPage).to receive(:exists?).with(slug: "privacy-policy").and_return(true)
      expect(LandingPage).to receive(:find).with("privacy-policy").and_return(privacy_policy)
      get :privacy_policy

      expect(assigns(:landing_page)).to eq(privacy_policy)
      expect(response).to be_success
      expect(response).to render_template("show")
    end
  end

  describe "GET terms_of_use" do
    it "responds with terms page" do
      terms_of_use = FactoryBot.create(:landing_page)
      expect(LandingPage).to receive(:exists?).with(slug: "terms-of-use").and_return(true)
      expect(LandingPage).to receive(:find).with("terms-of-use").and_return(terms_of_use)
      get :terms_of_use

      expect(assigns(:landing_page)).to eq(terms_of_use)
      expect(response).to be_success
      expect(response).to render_template("show")
    end
  end

end
