require 'rails_helper'

RSpec.describe ContactInfo::ContactEmail, type: :model do
  before do
    @contact_email_association = FactoryBot.create(:contact_info_contact_email)
  end  #  before do
  
  it 'Contact Email associations should be unique' do
    existing_contact = @contact_email_association.contact
    existing_email = @contact_email_association.email
	  new_contact_email = ContactInfo::ContactEmail.new(contact_info_contact_id: "#{existing_contact.id}", contact_info_email_id: "#{existing_email.id}")
	  expect(new_contact_email).not_to be_valid
	  expect(new_contact_email.errors.messages[:contact_info_email_id]).to include("has already been taken")    
  end  #  it 'Contact Email associations should be unique' do
  
end  #  RSpec.describe ContactInfo::ContactEmail, type: :model do