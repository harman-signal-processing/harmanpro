FactoryBot.define do
  factory :location_info_location_supported_country, class: 'LocationInfo::LocationSupportedCountry' do
    association :location, factory: :location_info_location
    association :country, factory: :location_info_country
    position { 1 }
  end
end
