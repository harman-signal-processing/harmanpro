require 'rails_helper'

RSpec.describe LocationInfo::LocationPhone, type: :model do
  before do
    @location_phone_association = FactoryBot.create(:location_info_location_phone)
  end  #  before do
  
  it 'Location phone associations should be unique' do
    existing_phone = @location_phone_association.phone
    existing_location = @location_phone_association.location
	  new_location_phone = LocationInfo::LocationPhone.new(contact_info_phone_id: "#{existing_phone.id}", location_info_location_id: "#{existing_location.id}")
	  expect(new_location_phone).not_to be_valid
	  expect(new_location_phone.errors.messages[:contact_info_phone_id]).to include("has already been taken")    
  end  #  it 'Location phone associations should be unique' do
end
