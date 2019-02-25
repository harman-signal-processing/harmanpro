require 'rails_helper'

RSpec.describe LocationInfo::LocationContact, type: :model do
  before do
    @location_contact_association = FactoryBot.create(:location_info_location_contact)
  end  #  before do
  
  it 'Location Contact associations should be unique' do
    existing_contact = @location_contact_association.contact
    existing_location = @location_contact_association.location
	  new_location_contact = LocationInfo::LocationContact.new(contact_info_contact_id: "#{existing_contact.id}", location_info_location_id: "#{existing_location.id}")
	  expect(new_location_contact).not_to be_valid
	  expect(new_location_contact.errors.messages[:contact_info_contact_id]).to include("has already been taken")    
  end  #  it 'Contact Location associations should be unique' do
end  #  RSpec.describe ContactInfo::ContactLocation, type: :model do