require 'rails_helper'

RSpec.describe ContactInfo::Phone, type: :model do
  before do
    @phone = FactoryBot.create(:contact_info_phone)
    @contact = FactoryBot.create(:contact_info_contact)     
  end  #  before do
  
  context 'Validate Phone attributes' do

  	it 'Phone should have expected attributes' do
  		expect(@phone.phone).to eq('123-456-7890')
  	end  #  it 'Phone should have expected attributes' do
  	
  	it 'Phone should be unique' do
  	  phone = ContactInfo::Phone.new(phone:'123-456-7890')
  	  expect(phone).not_to be_valid
  	  expect(phone.errors[:phone]).to include("has already been taken")
  	end  # it 'Phone name should be unique' do
  end  #  context 'Validate Phone attributes' do   
  
  context 'Validate Phone associations' do
  	it 'Phone should allow Contact associations' do
  		@phone.contacts << @contact
  		expect(@phone.contacts.count).to eq(1)
  	end
  	it 'Phone should allow removal of Contact associations' do
			@phone.contacts << @contact
  		expect(@phone.contacts.count).to eq(1)  		
  		@phone.contacts.destroy(@contact)
  		expect(@phone.contacts.count).to eq(0)
  	end     
  end  #  context 'Validate Phone associations' do  
  
end  #  RSpec.describe ContactInfo::Phone, type: :model do