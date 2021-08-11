require 'rails_helper'

RSpec.describe DistributorInfo::Distributor, type: :model do
  before :all do
    @distributor = FactoryBot.create(:distributor_info_distributor)
    @brand = FactoryBot.create(:brand)
    @location = FactoryBot.create(:location_info_location)
    @contact = FactoryBot.create(:contact_info_contact)
    @email = FactoryBot.create(:contact_info_email)
    @phone = FactoryBot.create(:contact_info_phone)
    @country = FactoryBot.create(:location_info_country)
  end  #  before do

  context 'Validate Distributor attributes' do
  	it 'Distributor should have expected attributes' do
  		expect(@distributor.name).to match(/Distributor \d*/)
  		expect(@distributor.account_number).to match('1234')
  	end  #  it 'Distributor should have expected attributes' do
  end  #  context 'Validate Distributor attributes' do

  context 'Validate Distributor associations' do
  	it 'Distributor should allow Brand associations' do
  		@distributor.brands << @brand
  		expect(@distributor.brands.size).to eq(1)
  	end
  	it 'Distributor should allow removal of Brand associations' do
			@distributor.brands << @brand
  		expect(@distributor.brands.size).to eq(1)
  		@distributor.brands.destroy(@brand)
  		expect(@distributor.brands.size).to eq(0)
  	end

  	it 'Distributor should allow Location associations' do
  		@distributor.locations << @location
  		expect(@distributor.locations.size).to eq(1)
  	end
  	it 'Distributor should allow removal of Location associations' do
			@distributor.locations << @location
  		expect(@distributor.locations.size).to eq(1)
  		@distributor.locations.destroy(@location)
  		expect(@distributor.locations.size).to eq(0)
  	end

  	it 'Distributor should allow Contact associations' do
  		@distributor.contacts << @contact
  		expect(@distributor.contacts.size).to eq(1)
  	end
  	it 'Distributor should allow removal of Contact associations' do
			@distributor.contacts << @contact
  		expect(@distributor.contacts.size).to eq(1)
  		@distributor.contacts.destroy(@contact)
  		expect(@distributor.contacts.size).to eq(0)
  	end

  	it 'Distributor should allow Email associations' do
  		@distributor.emails << @email
  		expect(@distributor.emails.size).to eq(1)
  	end
  	it 'Distributor should allow removal of Email associations' do
			@distributor.emails << @email
  		expect(@distributor.emails.size).to eq(1)
  		@distributor.emails.destroy(@email)
  		expect(@distributor.emails.size).to eq(0)
  	end

  	it 'Distributor should allow Phone associations' do
  		@distributor.phones << @phone
  		expect(@distributor.phones.size).to eq(1)
  	end
  	it 'Distributor should allow removal of Phone associations' do
			@distributor.phones << @phone
  		expect(@distributor.phones.size).to eq(1)
  		@distributor.phones.destroy(@phone)
  		expect(@distributor.phones.size).to eq(0)
  	end

  	it 'Distributor should allow Country associations' do
  		@distributor.countries << @country
  		expect(@distributor.countries.size).to eq(1)
  	end
  	it 'Distributor should allow removal of Country associations' do
			@distributor.countries << @country
  		expect(@distributor.countries.size).to eq(1)
  		@distributor.countries.destroy(@country)
  		expect(@distributor.countries.size).to eq(0)
  	end

  end  #  context 'Validate Distributor associations' do

end  #  RSpec.describe DistributorInfo::Distributor, type: :model do
