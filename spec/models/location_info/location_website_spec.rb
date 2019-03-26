require 'rails_helper'

RSpec.describe LocationInfo::LocationWebsite, type: :model do
  before do
    @location_website_association = FactoryBot.create(:location_info_location_website)
  end  #  before do
  
  it 'Location website associations should be unique' do
    existing_website = @location_website_association.website
    existing_location = @location_website_association.location
	  new_location_website = LocationInfo::LocationWebsite.new(contact_info_website_id: "#{existing_website.id}", location_info_location_id: "#{existing_location.id}")
	  expect(new_location_website).not_to be_valid
	  expect(new_location_website.errors.messages[:contact_info_website_id]).to include("has already been taken")    
  end  #  it 'Location website associations should be unique' do
end
