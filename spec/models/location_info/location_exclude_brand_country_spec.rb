require 'rails_helper'

RSpec.describe LocationInfo::LocationExcludeBrandCountry, type: :model do
  before do
    @location_excluded_brand_country_association = FactoryBot.create(:location_info_location_exclude_brand_country)
  end  #  before do
  
  it 'Location excluded brand country associations should be unique' do
    existing_location = @location_excluded_brand_country_association.location
    existing_country = @location_excluded_brand_country_association.country
    existing_brand = @location_excluded_brand_country_association.brand
	  new_location_excluded_brand_country = LocationInfo::LocationExcludeBrandCountry.new(location_info_location_id: "#{existing_location.id}", location_info_country_id: "#{existing_country.id}", brand_id: "#{existing_brand.id}")
	  expect(new_location_excluded_brand_country).not_to be_valid
	  expect(new_location_excluded_brand_country.errors.messages[:location_info_country_id]+new_location_excluded_brand_country.errors.messages[:brand_id]).to include("has already been taken")    
  end  #  it 'Location excluded brand country associations should be unique' do
end
