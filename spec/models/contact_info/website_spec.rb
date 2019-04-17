require 'rails_helper'

RSpec.describe ContactInfo::Website, type: :model do
  before do
    @website = FactoryBot.create(:contact_info_website)
    @contact = FactoryBot.create(:contact_info_contact)     
    @distributor = FactoryBot.create(:distributor_info_distributor)     
    @location = FactoryBot.create(:location_info_location)     
  end  #  before do
  
  context 'Validate Website attributes' do

  	it 'Website should have expected attributes' do
  		expect(@website.url).to eq('https://urltest.com')
  	end  #  it 'Website should have expected attributes' do
  	
  	it 'Website should be unique' do
  	  website = ContactInfo::Website.new(url:'https://urltest.com')
  	  expect(website).not_to be_valid
  	  expect(website.errors[:url]).to include("has already been taken")
  	end  # it 'Website name should be unique' do
  end  #  context 'Validate Website attributes' do   
  
  context 'Validate Website associations' do
  	it 'Website should allow Contact associations' do
  		@website.contacts << @contact
  		expect(@website.contacts.count).to eq(1)
  	end
  	it 'Website should allow removal of Contact associations' do
			@website.contacts << @contact
  		expect(@website.contacts.count).to eq(1)  		
  		@website.contacts.destroy(@contact)
  		expect(@website.contacts.count).to eq(0)
  	end   
  	
  	it 'Website should allow Distributor associations' do
  		@website.distributors << @distributor
  		expect(@website.distributors.count).to eq(1)
  	end
  	it 'Website should allow removal of Distributor associations' do
			@website.distributors << @distributor
  		expect(@website.distributors.count).to eq(1)  		
  		@website.distributors.destroy(@distributor)
  		expect(@website.distributors.count).to eq(0)
  	end    	
  	
  	it 'Website should allow Location associations' do
  		@website.locations << @location
  		expect(@website.locations.count).to eq(1)
  	end
  	it 'Website should allow removal of Location associations' do
			@website.locations << @location
  		expect(@website.locations.count).to eq(1)  		
  		@website.locations.destroy(@location)
  		expect(@website.locations.count).to eq(0)
  	end  	
  	
  end  #  context 'Validate Website associations' do  
  
end  #  RSpec.describe ContactInfo::Website, type: :model do