require 'rails_helper'

RSpec.describe LocationInfo::LocationRegion, type: :model do
  before do
    @location_region_association = FactoryBot.create(:location_info_location_region)
  end  #  before do
  it 'Location Region associations should be unique' do
    existing_region = @location_region_association.region
    existing_location = @location_region_association.location
	  new_location_region = LocationInfo::LocationRegion.new(location_info_region_id: "#{existing_region.id}", location_info_location_id: "#{existing_location.id}")
	  expect(new_location_region).not_to be_valid
	  expect(new_location_region.errors.messages[:location_info_region_id]).to include("has already been taken")    
  end  #  it 'Location Region associations should be unique' do
end  #  RSpec.describe LocationInfo::LocationRegion, type: :model do
