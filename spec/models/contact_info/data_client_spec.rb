require 'rails_helper'

RSpec.describe ContactInfo::DataClient, type: :model do
  before do
    @data_client = FactoryBot.create(:contact_info_data_client)
    @contact = FactoryBot.create(:contact_info_contact)
  end  #  before do

  context 'Validate DataClient attributes' do
  	it 'DataClient should have expected attributes' do
  		expect(@data_client.name).to eq('Data client 1')
  	end  #  it 'DataClient should have expected attributes' do

  	it 'DataClient should be unique' do
  	  data_client = ContactInfo::DataClient.new(name:'data client 1')
  	  expect(data_client).not_to be_valid
  	  expect(data_client.errors[:name]).to include("has already been taken")
  	end  # it 'DataClient name should be unique' do
  end  #  context 'Validate DataClient attributes' do

  context 'Validate DataClient associations' do
  	it 'DataClient should allow Contact associations' do
  		@data_client.contacts << @contact
  		expect(@data_client.contacts.size).to eq(1)
  	end
  	it 'DataClient should allow removal of Contact associations' do
			@data_client.contacts << @contact
  		expect(@data_client.contacts.size).to eq(1)
  		@data_client.contacts.destroy(@contact)
  		expect(@data_client.contacts.size).to eq(0)
  	end
  end  #  context 'Validate DataClient associations' do

end  # RSpec.describe ContactInfo::DataClient, type: :model do
