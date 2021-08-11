FactoryBot.define do
  factory :distributor_info_distributor_country, class: 'DistributorInfo::DistributorCountry' do
    association :distributor, factory: :distributor_info_distributor
    association :country, factory: :location_info_country
    position { 1 }
  end
end
