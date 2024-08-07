require 'rails_helper'

RSpec.describe ContactInfo::Email, type: :model do
  before :all do
    @email = FactoryBot.create(:contact_info_email)
    @contact = FactoryBot.create(:contact_info_contact)
    @distributor = FactoryBot.create(:distributor_info_distributor)
    @location = FactoryBot.create(:location_info_location)
  end  #  before do

  context 'Validate Email attributes' do
  	it 'Email should have expected attributes' do
  		expect(@email.email).to match(/email\d*/)
  	end  #  it 'Contact should have expected attributes' do

  	it 'Email should be unique' do
      email = ContactInfo::Email.new(email: @email.email)
  	  expect(email).not_to be_valid
  	  expect(email.errors[:email]).to include("has already been taken")
  	end  # it 'Email name should be unique' do
  end  #  context 'Validate Email attributes' do

  context 'Validate Email associations' do
  	it 'Email should allow Contact associations' do
  		@email.contacts << @contact
  		expect(@email.contacts.size).to eq(1)
  	end
  	it 'Email should allow removal of Contact associations' do
			@email.contacts << @contact
  		expect(@email.contacts.size).to eq(1)
  		@email.contacts.destroy(@contact)
  		expect(@email.contacts.size).to eq(0)
  	end

  	it 'Email should allow Distributor associations' do
  		@email.distributors << @distributor
  		expect(@email.distributors.size).to eq(1)
  	end
  	it 'Email should allow removal of Distributor associations' do
			@email.distributors << @distributor
  		expect(@email.distributors.size).to eq(1)
  		@email.distributors.destroy(@distributor)
  		expect(@email.distributors.size).to eq(0)
  	end

  	it 'Email should allow Location associations' do
  		@email.locations << @location
  		expect(@email.locations.size).to eq(1)
  	end
  	it 'Email should allow removal of Location associations' do
			@email.locations << @location
  		expect(@email.locations.size).to eq(1)
  		@email.locations.destroy(@location)
  		expect(@email.locations.size).to eq(0)
  	end

  end  #  context 'Validate Email associations' do

end  #  RSpec.describe ContactInfo::Email, type: :model do
