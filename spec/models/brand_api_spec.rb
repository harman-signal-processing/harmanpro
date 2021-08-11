require "rails_helper"

RSpec.describe BrandApi do

  before :all do
    @brand = FactoryBot.build(:brand, api_url: "http://localhost/foo")
  end

  before :each do
    expect(BrandApi).to receive(:get_api_response).and_return(true)
  end

  it "software(url) pulls software" do
    BrandApi.software(@brand.url)
  end

  it "product(url) pulls product" do
    BrandApi.product(@brand.url)
  end

  it "products(url) pulls products" do
    BrandApi.products(@brand.url)
  end

  it "info(url) gets info" do
    BrandApi.info(@brand.url)
  end
end
