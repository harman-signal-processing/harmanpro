require "rails_helper"

RSpec.describe BrandsController do

  before :all do
    @brand = FactoryGirl.create(:brand)
  end

  describe "GET :show" do

    it "assigns @brand" do
      get :show, params: { id: @brand.id }

      expect(assigns(:brand)).to eq(@brand)
    end

    it "(html) renders the brand page" do
      get :show, params: { id: @brand.id }

      expect(response).to render_template('brands/show')
    end

    it "(json) renders json data" do
      expect(BrandApi).to receive(:info).and_return(@brand.to_json)
      get :show, params: { id: @brand.id, format: :json }

      expect(response.content_type).to eq("application/json")
    end

    it "redirects to root for service-only brand" do
      service_brand = FactoryGirl.create(:brand, show_on_main_site: false)

      get :show, params: { id: service_brand.id }

      expect(response).to redirect_to(root_path)
    end

  end

  describe "GET :softwares (json)" do
    it "renders json" do
      expect(BrandApi).to receive(:software).and_return([])
      get :softwares, params: { id: @brand.id, format: :json }

      expect(response.content_type).to eq("application/json")
    end
  end


end
