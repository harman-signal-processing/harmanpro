require 'rails_helper'

RSpec.describe LocationInfo::LocationEmail, type: :model do
  before do
    @location_email_association = FactoryBot.create(:location_info_location_email)
  end  #  before do
  
  it 'Location email associations should be unique' do
    existing_email = @location_email_association.email
    existing_location = @location_email_association.location
	  new_location_email = LocationInfo::LocationEmail.new(contact_info_email_id: "#{existing_email.id}", location_info_location_id: "#{existing_location.id}")
	  expect(new_location_email).not_to be_valid
	  expect(new_location_email.errors.messages[:contact_info_email_id]).to include("has already been taken")    
  end  #  it 'Location email associations should be unique' do
end
