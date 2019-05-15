require 'rails_helper'

RSpec.describe DistributorInfo::DistributorExcludeBrandCountry, type: :model do
  before do
    @distributor_exclude_brand_country_association = FactoryBot.create(:distributor_info_distributor_exclude_brand_country)
  end  #  before do
  
  it 'Distributor exclude brand country associations should be unique' do
    existing_distributor = @distributor_exclude_brand_country_association.distributor
    existing_country = @distributor_exclude_brand_country_association.country
    existing_brand = @distributor_exclude_brand_country_association.brand
	  new_distributor_exclude_brand_country = DistributorInfo::DistributorExcludeBrandCountry.new(distributor_info_distributor_id: "#{existing_distributor.id}", location_info_country_id: "#{existing_country.id}", brand_id: "#{existing_brand.id}")
	  expect(new_distributor_exclude_brand_country).not_to be_valid
	  expect(new_distributor_exclude_brand_country.errors.messages[:location_info_country_id]+new_distributor_exclude_brand_country.errors.messages[:brand_id]).to include("has already been taken")    
  end  #  it 'Distributor exclude brand country associations should be unique' do
end
