require 'rails_helper'

RSpec.describe LocationInfo::Region, type: :model do
  before :all do
    @region = FactoryBot.create(:location_info_region)
    @location = FactoryBot.create(:location_info_location)
  end
  context 'Validate Region attributes' do
    it 'Region should have name' do
      expect(@region.name).to match('North America')
    end
    it 'Region name should be unique' do
      region = LocationInfo::Region.new(name: @region.name)
  	  expect(region).not_to be_valid
  	  expect(region.errors[:name]).to include("has already been taken")
    end
  end  #  context 'Validate Region attributes' do

  context 'Validate Region associations' do
  	it 'Region should allow Location associations' do
  		@region.locations << @location
  		expect(@region.locations.size).to eq(1)
  	end
  	it 'Region should allow removal of Location associations' do
			@region.locations << @location
  		expect(@region.locations.size).to eq(1)
  		@region.locations.destroy(@location)
  		expect(@region.locations.size).to eq(0)
  	end
  end  #  context 'Validate Region associations' do

end
