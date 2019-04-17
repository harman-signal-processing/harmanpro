require 'rails_helper'

RSpec.describe ContactInfo::ContactPhone, type: :model do
  before do
    @contact_phone_association = FactoryBot.create(:contact_info_contact_phone)
  end  #  before do
  
  it 'Contact Phone associations should be unique' do
    existing_contact = @contact_phone_association.contact
    existing_phone = @contact_phone_association.phone
	  new_contact_phone = ContactInfo::ContactPhone.new(contact_info_contact_id: "#{existing_contact.id}", contact_info_phone_id: "#{existing_phone.id}")
	  expect(new_contact_phone).not_to be_valid
	  expect(new_contact_phone.errors.messages[:contact_info_phone_id]).to include("has already been taken")    
  end  #  it 'Contact Phone associations should be unique' do
end  #  RSpec.describe ContactInfo::ContactPhone, type: :model do