FactoryBot.define do
  factory :distributor_info_distributor_phone, class: 'DistributorInfo::DistributorPhone' do
    distributor { DistributorInfo::Distributor.create(name: 'Distributor 1') }
    phone { ContactInfo::Phone.create(phone: '123 456-789') }
    position { 1 }     
  end
end
