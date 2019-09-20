FactoryBot.define do
  factory :location_info_location_supported_country, class: 'LocationInfo::LocationSupportedCountry' do
    location { LocationInfo::Location.create(name: 'Location 1', address1:'address1', city: 'city 1', country: 'country 1') }
    country { LocationInfo::Country.create(name: 'Country 1', harman_name: 'Country 1') }
    position { 1 }    
  end    
end
