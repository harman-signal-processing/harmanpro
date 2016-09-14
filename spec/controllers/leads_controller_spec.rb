require 'rails_helper'

RSpec.describe LeadsController, :type => :controller do

  describe "GET new" do
    before do
      get :new
    end

    it "assigns a new lead object" do
      expect(assigns(:lead)).to be_a_new(Lead)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    before do
      skip "Mailer hangs when run with entire suite"
      @lead = FactoryGirl.build(:lead)
      post :create, lead: @lead.attributes
    end

    it "creates the new lead" do
      lead = assigns(:lead)

      expect(lead.new_record?).to be false
      expect(lead.location).to eq(@lead.location)
      expect(lead.name).to eq(@lead.name)
    end

    it "redirects to the thankyou page" do
      expect(response).to redirect_to(thankyou_path)
    end

  end

end
