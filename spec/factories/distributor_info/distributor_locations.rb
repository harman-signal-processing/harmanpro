FactoryBot.define do
  factory :distributor_info_distributor_location, class: 'DistributorInfo::DistributorLocation' do
    distributor { DistributorInfo::Distributor.create(name: 'Distributor 1') }
    location { LocationInfo::Location.create(name: 'Location 1', address1:'address1', city: 'city 1', country: 'country 1') }
    position { 1 }
  end
end
