FactoryBot.define do
  factory :distributor_info_distributor_exclude_brand_country, class: 'DistributorInfo::DistributorExcludeBrandCountry' do
    association :distributor, factory: :distributor_info_distributor
    association :country, factory: :location_info_country
    brand
  end
end
