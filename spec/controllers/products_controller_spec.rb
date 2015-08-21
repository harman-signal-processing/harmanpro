require "rails_helper"

RSpec.describe ProductsController do

  before :all do
    @brand = FactoryGirl.create(:brand)
    @product = FactoryGirl.create(:product, brand: @brand)
  end

  describe "GET :index (json)" do

    it "renders json" do
      expect(BrandApi).to receive(:products).and_return([@product].to_json)
      get :index, brand_id: @brand.id, format: :json

      expect(response.content_type).to eq("application/json")
    end
  end

  describe "GET :show (json)" do

    it "renders json" do
      expect(BrandApi).to receive(:product).and_return(@product.to_json)
      get :show, brand_id: @brand.id, id: @product.id, format: :json

      expect(response.content_type).to eq("application/json")
    end
  end
end
