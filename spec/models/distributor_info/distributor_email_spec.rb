require 'rails_helper'

RSpec.describe DistributorInfo::DistributorEmail, type: :model do
  before do
    @distributor_email_association = FactoryBot.create(:distributor_info_distributor_email)
  end  #  before do
  
  it 'Distributor email associations should be unique' do
    existing_distributor = @distributor_email_association.distributor
    existing_email = @distributor_email_association.email
	  new_distributor_email = DistributorInfo::DistributorEmail.new(distributor_info_distributor_id: "#{existing_distributor.id}", contact_info_email_id: "#{existing_email.id}")
	  expect(new_distributor_email).not_to be_valid
	  expect(new_distributor_email.errors.messages[:contact_info_email_id]).to include("has already been taken")    
  end  #  it 'Distributor Brand associations should be unique' do
end
