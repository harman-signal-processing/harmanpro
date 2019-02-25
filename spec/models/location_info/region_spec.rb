require 'rails_helper'

RSpec.describe LocationInfo::Region, type: :model do
  before do
    @region = FactoryBot.create(:location_info_region)
  end
  context 'Validate Region attributes' do
    it 'Region should have name' do
      expect(@region.name).to eq('North America')
    end
    it 'Region name should be unique' do
  	  region = LocationInfo::Region.new(name:'North America')
  	  expect(region).not_to be_valid
  	  expect(region.errors[:name]).to include("has already been taken")      
    end
  end  #  context 'Validate Region attributes' do
end
