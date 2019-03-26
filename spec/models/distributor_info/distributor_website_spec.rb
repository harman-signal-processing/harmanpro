require 'rails_helper'

RSpec.describe DistributorInfo::DistributorWebsite, type: :model do
  before do
    @distributor_website_association = FactoryBot.create(:distributor_info_distributor_website)
  end  #  before do
  
  it 'Distributor website associations should be unique' do
    existing_distributor = @distributor_website_association.distributor
    existing_website = @distributor_website_association.website
	  new_distributor_website = DistributorInfo::DistributorWebsite.new(distributor_info_distributor_id: "#{existing_distributor.id}", contact_info_website_id: "#{existing_website.id}")
	  expect(new_distributor_website).not_to be_valid
	  expect(new_distributor_website.errors.messages[:contact_info_website_id]).to include("has already been taken")    
  end  #  it 'Distributor website associations should be unique' do
end
