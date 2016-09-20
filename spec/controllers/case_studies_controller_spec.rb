require 'rails_helper'

RSpec.describe CaseStudiesController, :type => :controller do

  before :all do
    csvm = FactoryGirl.create(:case_study_vertical_market)
    @vertical_market = csvm.vertical_market
    @case_study = csvm.case_study
  end

  describe "GET show" do
    before do
      get :show, id: @case_study.id
    end

    it "assigns @case_study" do
      expect(assigns(:case_study)).to eq(@case_study)
    end

    it "renders show template" do
      expect(response).to render_template("show")
      expect(response).to have_http_status(:success)
    end
  end

end
