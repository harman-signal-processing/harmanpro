FactoryBot.define do
  factory :distributor_info_distributor_location, class: 'DistributorInfo::DistributorLocation' do
    association :distributor, factory: :distributor_info_distributor
    association :location, factory: :location_info_location
    position { 1 }
  end
end
