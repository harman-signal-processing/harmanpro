FactoryBot.define do
  factory :location_info_location_region, class: 'LocationInfo::LocationRegion' do
    location { LocationInfo::Location.create(name: 'Location 1', address1:'address1', city: 'city 1', country: 'country 1') }
    region { LocationInfo::Region.create(name: 'North America') }
    position { 1 }
  end
end
