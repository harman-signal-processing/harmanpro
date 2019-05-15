FactoryBot.define do
  factory :location_info_location_exclude_brand_country, class: 'LocationInfo::LocationExcludeBrandCountry' do
    location { LocationInfo::Location.create(name: 'Location 1', address1:'address1', city: 'city 1', country: 'country 1') }
    country { LocationInfo::Country.create(name: 'Country 1') }
    brand { Brand.create(name: 'Brand 1', url: 'https://www.brand.com') }     
  end
end
