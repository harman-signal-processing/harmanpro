require 'rails_helper'

RSpec.describe DistributorInfo::DistributorCountry, type: :model do
  before do
    @distributor_country_association = FactoryBot.create(:distributor_info_distributor_country)
  end  #  before do
  
  it 'Distributor country associations should be unique' do
    existing_distributor = @distributor_country_association.distributor
    existing_country = @distributor_country_association.country
	  new_distributor_country = DistributorInfo::DistributorCountry.new(distributor_info_distributor_id: "#{existing_distributor.id}", location_info_country_id: "#{existing_country.id}")
	  expect(new_distributor_country).not_to be_valid
	  expect(new_distributor_country.errors.messages[:location_info_country_id]).to include("has already been taken")    
  end  #  it 'Distributor Brand associations should be unique' do
end
