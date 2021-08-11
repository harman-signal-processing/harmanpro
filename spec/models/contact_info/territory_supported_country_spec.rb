require 'rails_helper'

RSpec.describe ContactInfo::TerritorySupportedCountry, type: :model do
  before do
    @territory_supported_country_association = FactoryBot.create(:contact_info_territory_supported_country)
  end  #  before do

  it 'Territory supported country associations should be unique' do
    existing_territory = @territory_supported_country_association.territory
    existing_country = @territory_supported_country_association.country
    new_territory_supported_country = ContactInfo::TerritorySupportedCountry.new(contact_info_territory_id: "#{existing_territory.id}", location_info_country_id: "#{existing_country.id}")
	  expect(new_territory_supported_country).not_to be_valid
	  expect(new_territory_supported_country.errors.messages[:location_info_country_id]).to include("has already been taken")
  end  #  it 'Territory supported country associations should be unique' do

end  #  RSpec.describe ContactInfo::TerritorySupportedCountry, type: :model do
