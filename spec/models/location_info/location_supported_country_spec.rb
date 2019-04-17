require 'rails_helper'

RSpec.describe LocationInfo::LocationSupportedCountry, type: :model do
  before do
    @location_supported_country_association = FactoryBot.create(:location_info_location_supported_country)
  end  #  before do
  
  it 'Location supported country associations should be unique' do
    existing_location = @location_supported_country_association.location
    existing_country = @location_supported_country_association.country
	  new_location_supported_country = LocationInfo::LocationSupportedCountry.new(location_info_location_id: "#{existing_location.id}", location_info_country_id: "#{existing_country.id}")
	  expect(new_location_supported_country).not_to be_valid
	  expect(new_location_supported_country.errors.messages[:location_info_country_id]).to include("has already been taken")    
  end  #  it 'Location supported country associations should be unique' do
end
