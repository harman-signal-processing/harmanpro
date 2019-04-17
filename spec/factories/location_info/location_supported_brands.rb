FactoryBot.define do
  factory :location_info_location_supported_brand, class: 'LocationInfo::LocationSupportedBrand' do
    location { LocationInfo::Location.create(name: 'Location 1', address1:'address1', city: 'city 1', country: 'country 1') }
    brand { Brand.create(name: 'Brand 1', url: 'https://www.brand.com') }
    position { 1 }     
  end
end
