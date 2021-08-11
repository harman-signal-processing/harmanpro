FactoryBot.define do
  factory :distributor_info_distributor_phone, class: 'DistributorInfo::DistributorPhone' do
    association :distributor, factory: :distributor_info_distributor
    association :phone, factory: :contact_info_phone
    position { 1 }
  end
end
