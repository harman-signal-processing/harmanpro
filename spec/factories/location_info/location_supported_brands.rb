FactoryBot.define do
  factory :location_info_location_supported_brand, class: 'LocationInfo::LocationSupportedBrand' do
    association :location, factory: :location_info_location
    brand
    position { 1 }
  end
end
