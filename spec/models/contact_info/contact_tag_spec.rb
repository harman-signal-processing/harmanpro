require 'rails_helper'

RSpec.describe ContactInfo::ContactTag, type: :model do
  before do
    @contact_tag_association = FactoryBot.create(:contact_info_contact_tag)
  end  #  before do
  
  it 'Contact Tag associations should be unique' do
    existing_contact = @contact_tag_association.contact
    existing_tag = @contact_tag_association.tag
	  new_contact_tag = ContactInfo::ContactTag.new(contact_info_contact_id: "#{existing_contact.id}", contact_info_tag_id: "#{existing_tag.id}")
	  expect(new_contact_tag).not_to be_valid
	  expect(new_contact_tag.errors.messages[:contact_info_tag_id]).to include("has already been taken")    
  end  #  it 'Contact Tag associations should be unique' do
end  #  RSpec.describe ContactInfo::ContactTag, type: :model do