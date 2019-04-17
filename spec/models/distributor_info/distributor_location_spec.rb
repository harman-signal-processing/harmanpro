require 'rails_helper'

RSpec.describe DistributorInfo::DistributorLocation, type: :model do
  before do
    @distributor_location_association = FactoryBot.create(:distributor_info_distributor_location)
  end  #  before do
  
  it 'Distributor location associations should be unique' do
    existing_distributor = @distributor_location_association.distributor
    existing_location = @distributor_location_association.location
	  new_distributor_location = DistributorInfo::DistributorLocation.new(distributor_info_distributor_id: "#{existing_distributor.id}", location_info_location_id: "#{existing_location.id}")
	  expect(new_distributor_location).not_to be_valid
	  expect(new_distributor_location.errors.messages[:location_info_location_id]).to include("has already been taken")    
  end  #  it 'Distributor Brand associations should be unique' do
end
