require 'rails_helper'

RSpec.describe ContactInfo::ContactDataClient, type: :model do
  before do
    @contact_dataclient = FactoryBot.create(:contact_info_contact_data_client)
  end  #  before do
  
  it 'Contact DataClient associations should be unique' do
    existing_contact = @contact_dataclient.contact
    existing_data_client = @contact_dataclient.data_client
	  new_contact_data_client = ContactInfo::ContactDataClient.new(contact_info_contact_id: "#{existing_contact.id}", contact_info_data_client_id: "#{existing_data_client.id}")
	  expect(new_contact_data_client).not_to be_valid
	  expect(new_contact_data_client.errors.messages[:contact_info_data_client_id]).to include("has already been taken")    
  end  #  it 'ContactDataClients should require uniqueness' do
  
end  #  RSpec.describe ContactInfo::ContactDataClient, type: :model do
