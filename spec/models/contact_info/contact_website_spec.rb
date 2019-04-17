require 'rails_helper'

RSpec.describe ContactInfo::ContactWebsite, type: :model do
  before do
    @contact_website_association = FactoryBot.create(:contact_info_contact_website)
  end  #  before do
  
  it 'Contact Website associations should be unique' do
    existing_contact = @contact_website_association.contact
    existing_website = @contact_website_association.website
	  new_contact_website = ContactInfo::ContactWebsite.new(contact_info_contact_id: "#{existing_contact.id}", contact_info_website_id: "#{existing_website.id}")
	  expect(new_contact_website).not_to be_valid
	  expect(new_contact_website.errors.messages[:contact_info_website_id]).to include("has already been taken")    
  end  #  it 'Contact Website associations should be unique' do
end  #  RSpec.describe ContactInfo::ContactWebsite, type: :model do