require 'rails_helper'

RSpec.describe ContactInfo::ContactProSiteOption, type: :model do
  before do
    @contact_prositeoption_association = FactoryBot.create(:contact_info_contact_pro_site_option)
  end  #  before do
  
  it 'Contact ProSiteOption associations should be unique' do
    existing_contact = @contact_prositeoption_association.contact
	  new_contact_prositeoption_association = ContactInfo::ContactProSiteOption.new(contact_info_contact_id: "#{existing_contact.id}")
	  expect(new_contact_prositeoption_association).not_to be_valid
	  expect(new_contact_prositeoption_association.errors.messages[:contact_info_contact_id]).to include("has already been taken")    
  end  #  it 'Contact ProSiteOption associations should be unique' do
end  #  RSpec.describe ContactInfo::ContactProSiteOption, type: :model do
