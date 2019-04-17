require 'rails_helper'

RSpec.describe LocationInfo::LocationSupportedBrand, type: :model do
  before do
    @location_supported_brand_association = FactoryBot.create(:location_info_location_supported_brand)
  end  #  before do
  
  it 'Location supported brand associations should be unique' do
    existing_location = @location_supported_brand_association.location
    existing_brand = @location_supported_brand_association.brand
	  new_location_supported_brand = LocationInfo::LocationSupportedBrand.new(location_info_location_id: "#{existing_location.id}", brand_id: "#{existing_brand.id}")
	  expect(new_location_supported_brand).not_to be_valid
	  expect(new_location_supported_brand.errors.messages[:brand_id]).to include("has already been taken")    
  end  #  it 'Location supported brand associations should be unique' do
end
