require 'rails_helper'

RSpec.describe DistributorInfo::DistributorBrand, type: :model do
  before do
    @distributor_brand_association = FactoryBot.create(:distributor_info_distributor_brand)
  end  #  before do
  
  it 'Distributor Brand associations should be unique' do
    existing_distributor = @distributor_brand_association.distributor
    existing_brand = @distributor_brand_association.brand
	  new_distributor_brand = DistributorInfo::DistributorBrand.new(distributor_info_distributor_id: "#{existing_distributor.id}", brand_id: "#{existing_brand.id}")
	  expect(new_distributor_brand).not_to be_valid
	  expect(new_distributor_brand.errors.messages[:brand_id]).to include("has already been taken")    
  end  #  it 'Distributor Brand associations should be unique' do
end
