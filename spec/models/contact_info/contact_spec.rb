require 'rails_helper'

RSpec.describe ContactInfo::Contact, type: :model do
  before do
    @contact = FactoryBot.create(:contact_info_contact)
    @location = FactoryBot.create(:location_info_location)
    @team_group = FactoryBot.create(:contact_info_team_group)
    @territory = FactoryBot.create(:contact_info_territory)
    @email = FactoryBot.create(:contact_info_email)
    @phone = FactoryBot.create(:contact_info_phone)
    @website = FactoryBot.create(:contact_info_website)
    @tag = FactoryBot.create(:contact_info_tag)
    @data_client = FactoryBot.create(:contact_info_data_client)
    @supported_brand = FactoryBot.create(:brand)
    @supported_country = FactoryBot.create(:location_info_country)
  end  #  before do
  context 'Validate Contact attributes' do

  	it 'Contact should have expected attributes' do
  		expect(@contact.name).to eq('Contact 1')
  	end  #  it 'Contact should have expected attributes' do
  	
  	it 'Contact name should be unique' do
  	  contact = ContactInfo::Contact.new(name:'Contact 1')
  	  expect(contact).not_to be_valid
  	  expect(contact.errors[:name]).to include("has already been taken")
  	end  # it 'Contact name should be unique' do
  end  #  context 'Validate Contact attributes' do
  
  context 'Validate Contact associations' do
  	it 'Contact should allow Location associations' do
  		@contact.locations << @location
  		expect(@contact.locations.count).to eq(1)
  	end
  	it 'Contact should allow removal of Location associations' do
			@contact.locations << @location
  		expect(@contact.locations.count).to eq(1)  		
  		@contact.locations.destroy(@location)
  		expect(@contact.locations.count).to eq(0)
  	end    
  	
  	it 'Contact should allow TeamGroup associations' do
  		@contact.team_groups << @team_group
  		expect(@contact.team_groups.count).to eq(1)
  	end
  	it 'Contact should allow removal of TeamGroup associations' do
			@contact.team_groups << @team_group
  		expect(@contact.team_groups.count).to eq(1)  		
  		@contact.team_groups.destroy(@team_group)
  		expect(@contact.team_groups.count).to eq(0)
  	end      	
  	
  	it 'Contact should allow Territory associations' do
  		@contact.territories << @territory
  		expect(@contact.territories.count).to eq(1)
  	end
  	it 'Contact should allow removal of Territory associations' do
			@contact.territories << @territory
  		expect(@contact.territories.count).to eq(1)  		
  		@contact.territories.destroy(@territory)
  		expect(@contact.territories.count).to eq(0)
  	end  	
  	
  	it 'Contact should allow Email associations' do
  		@contact.emails << @email
  		expect(@contact.emails.count).to eq(1)
  	end
  	it 'Contact should allow removal of Email associations' do
			@contact.emails << @email
  		expect(@contact.emails.count).to eq(1)  		
  		@contact.emails.destroy(@email)
  		expect(@contact.emails.count).to eq(0)
  	end   	
  	
  	it 'Contact should allow Phone associations' do
  		@contact.phones << @phone
  		expect(@contact.phones.count).to eq(1)
  	end
  	it 'Contact should allow removal of Phone associations' do
			@contact.phones << @phone
  		expect(@contact.phones.count).to eq(1)  		
  		@contact.phones.destroy(@phone)
  		expect(@contact.phones.count).to eq(0)
  	end   	
  	
  	it 'Contact should allow Website associations' do
  		@contact.websites << @website
  		expect(@contact.websites.count).to eq(1)
  	end
  	it 'Contact should allow removal of Website associations' do
			@contact.websites << @website
  		expect(@contact.websites.count).to eq(1)  		
  		@contact.websites.destroy(@website)
  		expect(@contact.websites.count).to eq(0)
  	end  	
  	
  	it 'Contact should allow Tag associations' do
  		@contact.tags << @tag
  		expect(@contact.tags.count).to eq(1)
  	end
  	it 'Contact should allow removal of Tag associations' do
			@contact.tags << @tag
  		expect(@contact.tags.count).to eq(1)  		
  		@contact.tags.destroy(@tag)
  		expect(@contact.tags.count).to eq(0)
  	end   	
  	
  	it 'Contact should allow DataClient associations' do
  		@contact.data_clients << @data_client
  		expect(@contact.data_clients.count).to eq(1)
  	end
  	it 'Contact should allow removal of DataClient associations' do
			@contact.data_clients << @data_client
  		expect(@contact.data_clients.count).to eq(1)  		
  		@contact.data_clients.destroy(@data_client)
  		expect(@contact.data_clients.count).to eq(0)
  	end   	
  	
  	it 'Contact should allow supported Brand associations' do
  		@contact.supported_brands << @supported_brand
  		expect(@contact.supported_brands.count).to eq(1)
  	end
  	it 'Contact should allow removal of supported Brand associations' do
			@contact.supported_brands << @supported_brand
  		expect(@contact.supported_brands.count).to eq(1)  		
  		@contact.supported_brands.destroy(@supported_brand)
  		expect(@contact.supported_brands.count).to eq(0)
  	end   	
  	
  	it 'Contact should allow supported Country associations' do
  		@contact.supported_countries << @supported_country
  		expect(@contact.supported_countries.count).to eq(1)
  	end
  	it 'Contact should allow removal of supported Country associations' do
			@contact.supported_countries << @supported_country
  		expect(@contact.supported_countries.count).to eq(1)  		
  		@contact.supported_countries.destroy(@supported_country)
  		expect(@contact.supported_countries.count).to eq(0)
  	end  	
  	
  end  #  context 'Validate Contact associations' do
  
end  #  RSpec.describe ContactInfo::Contact, type: :model do