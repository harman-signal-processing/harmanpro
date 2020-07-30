require 'rails_helper'

RSpec.describe LeadsController, :type => :controller do

  describe "GET new" do
    before do
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    before do
      skip "Mailer hangs when run with entire suite"
      @lead = FactoryBot.build(:lead)
      post :create, params: { lead: @lead.attributes }
    end

    it "redirects to the thankyou page" do
      expect(response).to redirect_to(thankyou_path)
    end

  end

end
