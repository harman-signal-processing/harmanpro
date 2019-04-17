require 'rails_helper'

RSpec.describe DistributorInfo::DistributorPhone, type: :model do
  before do
    @distributor_phone_association = FactoryBot.create(:distributor_info_distributor_phone)
  end  #  before do
  
  it 'Distributor phone associations should be unique' do
    existing_distributor = @distributor_phone_association.distributor
    existing_phone = @distributor_phone_association.phone
	  new_distributor_phone = DistributorInfo::DistributorPhone.new(distributor_info_distributor_id: "#{existing_distributor.id}", contact_info_phone_id: "#{existing_phone.id}")
	  expect(new_distributor_phone).not_to be_valid
	  expect(new_distributor_phone.errors.messages[:contact_info_phone_id]).to include("has already been taken")    
  end  #  it 'Distributor phone associations should be unique' do
end
