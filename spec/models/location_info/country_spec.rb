require 'rails_helper'

RSpec.describe LocationInfo::Country, type: :model do
  before :all do
    @country = FactoryBot.create(:location_info_country)
    @distributor = FactoryBot.create(:distributor_info_distributor)
  end

  context 'Validate Country attributes' do
  	it 'Location should have expected attributes' do
  		expect(@country.name).to match('United States of America')
  		expect(@country.harman_name).to match('United States of America')
  		expect(@country.alpha2).to eq('US')
  		expect(@country.alpha3).to eq('USA')
  		expect(@country.continent).to eq('North America')
  		expect(@country.region).to eq('Americas')
  		expect(@country.sub_region).to eq('Northern America')
  		expect(@country.world_region).to eq('AMER')
  		expect(@country.harman_world_region).to eq('AMER')
  		expect(@country.calling_code).to eq(1)
  		expect(@country.numeric_code).to eq(840)
  	end  #  it 'Country should have expected attributes' do
  end  #  context 'Validate Country attributes' do

  context 'Validate Country associations' do
  	it 'Country should allow Distributor associations' do
  		@country.distributors << @distributor
  		expect(@country.distributors.size).to eq(1)
  	end
  	it 'Country should allow removal of Distributor associations' do
			@country.distributors << @distributor
  		expect(@country.distributors.size).to eq(1)
  		@country.distributors.destroy(@distributor)
  		expect(@country.distributors.size).to eq(0)
  	end
	end  #  context 'Validate Country associations' do

end  #  RSpec.describe LocationInfo::Country, type: :model do
