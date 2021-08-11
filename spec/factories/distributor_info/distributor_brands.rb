FactoryBot.define do
  factory :distributor_info_distributor_brand, class: 'DistributorInfo::DistributorBrand' do
    association :distributor, factory: :distributor_info_distributor
    brand
  end
end
