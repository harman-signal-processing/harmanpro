FactoryBot.define do
  factory :distributor_info_distributor_contact, class: 'DistributorInfo::DistributorContact' do
    distributor { DistributorInfo::Distributor.create(name: 'Distributor 1') }
    contact { ContactInfo::Contact.create(name: 'Contact 1') }
    position { 1 }
  end
end