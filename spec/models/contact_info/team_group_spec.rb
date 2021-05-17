require 'rails_helper'

RSpec.describe ContactInfo::TeamGroup, type: :model do
  before do
    @team_group = FactoryBot.create(:contact_info_team_group)
    @contact = FactoryBot.create(:contact_info_contact)
  end  #  before do

  context 'Validate TeamGroup associations' do
  	it 'TeamGroup should allow Contact associations' do
  		@team_group.contacts << @contact
  		expect(@team_group.contacts.size).to eq(1)
  	end
  	it 'TeamGroup should allow removal of Contact associations' do
			@team_group.contacts << @contact
  		expect(@team_group.contacts.size).to eq(1)
  		@team_group.contacts.destroy(@contact)
  		expect(@team_group.contacts.size).to eq(0)
  	end
  end  #  context 'Validate TeamGroup associations' do

end  #  RSpec.describe ContactInfo::TeamGroup, type: :model do
