require 'rails_helper'

RSpec.describe ContactInfo::Territory, type: :model do
  before do
    @territory = FactoryBot.create(:contact_info_territory)
    @contact = FactoryBot.create(:contact_info_contact)
  end  #  before do

  context 'Validate Territory associations' do
  	it 'Territory should allow Contact associations' do
  		@territory.contacts << @contact
  		expect(@territory.contacts.size).to eq(1)
  	end
  	it 'Territory should allow removal of Contact associations' do
			@territory.contacts << @contact
  		expect(@territory.contacts.size).to eq(1)
  		@territory.contacts.destroy(@contact)
  		expect(@territory.contacts.size).to eq(0)
  	end
  end  #  context 'Validate Territory associations' do

end  #  RSpec.describe ContactInfo::Territory, type: :model do
