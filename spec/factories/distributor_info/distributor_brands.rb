FactoryBot.define do
  factory :distributor_info_distributor_brand, class: 'DistributorInfo::DistributorBrand' do
    distributor { DistributorInfo::Distributor.create(name: 'Distributor 1') }
    brand { Brand.create(name: 'Brand 1', url: 'https://www.brand.com') }
  end
end
