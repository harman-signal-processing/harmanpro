FactoryBot.define do
  factory :distributor_info_distributor_email, class: 'DistributorInfo::DistributorEmail' do
    distributor { DistributorInfo::Distributor.create(name: 'Distributor 1') }
    email { ContactInfo::Email.create(email: 'email@test.com') }
    position { 1 }    
  end
end
