require 'rails_helper'

RSpec.describe LocationInfo::Location, type: :model do
  before do
    @location = FactoryBot.create(:location_info_location)
    @contact = FactoryBot.create(:contact_info_contact) 
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
  		expect(@location.contacts.count).to eq(1)
  	end
  	it 'Location should allow removal of Contact associations' do
			@location.contacts << @contact
  		expect(@location.contacts.count).to eq(1)  		
  		@location.contacts.destroy(@contact)
  		expect(@location.contacts.count).to eq(0)
  	end     
  end  #  context 'Validate Location associations' do
end  #  RSpec.describe LocationInfo::Location, type: :model do
