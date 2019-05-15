FactoryBot.define do
  factory :distributor_info_distributor_exclude_brand_country, class: 'DistributorInfo::DistributorExcludeBrandCountry' do
    distributor { DistributorInfo::Distributor.create(name: 'Distributor 1') }
    country { LocationInfo::Country.create(name: 'Country 1') }    
    brand { Brand.create(name: 'Brand 1', url: 'https://www.brand.com') }
  end
end
