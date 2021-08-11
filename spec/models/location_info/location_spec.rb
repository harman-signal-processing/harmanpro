require 'rails_helper'

RSpec.describe LocationInfo::Location, type: :model do
  before :all do
    @location = FactoryBot.create(:location_info_location)
    @contact = FactoryBot.create(:contact_info_contact)
    @email = FactoryBot.create(:contact_info_email)
    @phone = FactoryBot.create(:contact_info_phone)
    @website = FactoryBot.create(:contact_info_website)
    @region = FactoryBot.create(:location_info_region)
    @distributor = FactoryBot.create(:distributor_info_distributor)
    @brand = FactoryBot.create(:brand)
  end  #  before do

  context 'Validate Location attributes' do
  	it 'Location should have expected attributes' do
  		expect(@location.name).to eq('name 1')
  		expect(@location.address1).to eq('address 1')
  		expect(@location.city).to eq('city')
  		expect(@location.country).to eq('country')
  	end  #  it 'Location should have expected attributes' do
  end  #  context 'Validate Location attributes' do

  context 'Validate Location associations' do
  	it 'Location should allow Contact associations' do
  		@location.contacts << @contact
  		expect(@location.contacts.size).to eq(1)
  	end
  	it 'Location should allow removal of Contact associations' do
			@location.contacts << @contact
  		expect(@location.contacts.size).to eq(1)
  		@location.contacts.destroy(@contact)
  		expect(@location.contacts.size).to eq(0)
  	end

  	it 'Location should allow Email associations' do
  		@location.emails << @email
  		expect(@location.emails.size).to eq(1)
  	end
  	it 'Location should allow removal of Email associations' do
			@location.emails << @email
  		expect(@location.emails.size).to eq(1)
  		@location.emails.destroy(@email)
  		expect(@location.emails.size).to eq(0)
  	end

  	it 'Location should allow Phone associations' do
  		@location.phones << @phone
  		expect(@location.phones.size).to eq(1)
  	end
  	it 'Location should allow removal of Phone associations' do
			@location.phones << @phone
  		expect(@location.phones.size).to eq(1)
  		@location.phones.destroy(@phone)
  		expect(@location.phones.size).to eq(0)
  	end

  	it 'Location should allow Website associations' do
  		@location.websites << @website
  		expect(@location.websites.size).to eq(1)
  	end
  	it 'Location should allow removal of Website associations' do
			@location.websites << @website
  		expect(@location.websites.size).to eq(1)
  		@location.websites.destroy(@website)
  		expect(@location.websites.size).to eq(0)
  	end

  	it 'Location should allow Region associations' do
  		@location.regions << @region
  		expect(@location.regions.size).to eq(1)
  	end
  	it 'Location should allow removal of Region associations' do
			@location.regions << @region
  		expect(@location.regions.size).to eq(1)
  		@location.regions.destroy(@region)
  		expect(@location.regions.size).to eq(0)
  	end

  	it 'Location should allow Distributor associations' do
  		@location.distributors << @distributor
  		expect(@location.distributors.size).to eq(1)
  	end
  	it 'Location should allow removal of Distributor associations' do
			@location.distributors << @distributor
  		expect(@location.distributors.size).to eq(1)
  		@location.distributors.destroy(@distributor)
  		expect(@location.distributors.size).to eq(0)
  	end

  	it 'Location should allow Brand associations' do
  		@location.distributors << @distributor
  		expect(@location.distributors.size).to eq(1)
  	end
  	it 'Location should allow removal of Brand associations' do
			@location.supported_brands << @brand
  		expect(@location.supported_brands.size).to eq(1)
  		@location.supported_brands.destroy(@brand)
  		expect(@location.supported_brands.size).to eq(0)
  	end

  end  #  context 'Validate Location associations' do
end  #  RSpec.describe LocationInfo::Location, type: :model do
