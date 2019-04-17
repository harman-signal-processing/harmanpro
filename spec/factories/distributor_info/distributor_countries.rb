FactoryBot.define do
  factory :distributor_info_distributor_country, class: 'DistributorInfo::DistributorCountry' do
    distributor { DistributorInfo::Distributor.create(name: 'Distributor 1') }
    country { LocationInfo::Country.create(name: 'Country 1') }
    position { 1 }    
  end
end
