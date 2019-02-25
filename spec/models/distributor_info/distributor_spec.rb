require 'rails_helper'

RSpec.describe DistributorInfo::Distributor, type: :model do
  before do
    @distributor = FactoryBot.create(:distributor_info_distributor)
    @brand = FactoryBot.create(:brand) 
  end  #  before do
  
  context 'Validate Distributor attributes' do
  	it 'Distributor should have expected attributes' do
  		expect(@distributor.name).to eq('Distributor 1')
  		expect(@distributor.account_number).to eq('12345')
  	end  #  it 'Distributor should have expected attributes' do
  end  #  context 'Validate Distributor attributes' do   
  
  context 'Validate Distributor associations' do
  	it 'Distributor should allow Brand associations' do
  		@distributor.brands << @brand
  		expect(@distributor.brands.count).to eq(1)
  	end
  	it 'Distributor should allow removal of Brand associations' do
			@distributor.brands << @brand
  		expect(@distributor.brands.count).to eq(1)  		
  		@distributor.brands.destroy(@brand)
  		expect(@distributor.brands.count).to eq(0)
  	end     
  end  #  context 'Validate Distributor associations' do  
  
end  #  RSpec.describe DistributorInfo::Distributor, type: :model do
