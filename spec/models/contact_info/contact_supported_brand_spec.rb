require 'rails_helper'

RSpec.describe ContactInfo::ContactSupportedBrand, type: :model do
  before do
    @contact_supported_brand_association = FactoryBot.create(:contact_info_contact_supported_brand)
  end  #  before do
  
  it 'contact supported brand associations should be unique' do
    existing_contact = @contact_supported_brand_association.contact
    existing_brand = @contact_supported_brand_association.brand
	  new_contact_supported_brand = ContactInfo::ContactSupportedBrand.new(contact_info_contact_id: "#{existing_contact.id}", brand_id: "#{existing_brand.id}")
	  expect(new_contact_supported_brand).not_to be_valid
	  expect(new_contact_supported_brand.errors.messages[:brand_id]).to include("has already been taken")    
  end  #  it 'Contact supported brand associations should be unique' do
end
