require 'rails_helper'

RSpec.describe DistributorInfo::DistributorContact, type: :model do
  before do
    @distributor_contact_association = FactoryBot.create(:distributor_info_distributor_contact)
  end  #  before do
  
  it 'Distributor contact associations should be unique' do
    existing_distributor = @distributor_contact_association.distributor
    existing_contact = @distributor_contact_association.contact
	  new_distributor_contact = DistributorInfo::DistributorContact.new(distributor_info_distributor_id: "#{existing_distributor.id}", contact_info_contact_id: "#{existing_contact.id}")
	  expect(new_distributor_contact).not_to be_valid
	  expect(new_distributor_contact.errors.messages[:contact_info_contact_id]).to include("has already been taken")    
  end  #  it 'Distributor Brand associations should be unique' do
end
