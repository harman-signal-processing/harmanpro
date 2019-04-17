require 'rails_helper'

RSpec.describe ContactInfo::ContactSupportedCountry, type: :model do
  before do
    @contact_supported_country_association = FactoryBot.create(:contact_info_contact_supported_country)
  end  #  before do
  
  it 'Contact supported country associations should be unique' do
    existing_contact = @contact_supported_country_association.contact
    existing_country = @contact_supported_country_association.country
	  new_contact_supported_country = ContactInfo::ContactSupportedCountry.new(contact_info_contact_id: "#{existing_contact.id}", location_info_country_id: "#{existing_country.id}")
	  expect(new_contact_supported_country).not_to be_valid
	  expect(new_contact_supported_country.errors.messages[:location_info_country_id]).to include("has already been taken")    
  end  #  it 'contact supported country associations should be unique' do
end
