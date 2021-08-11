FactoryBot.define do
  factory :location_info_location_exclude_brand_country, class: 'LocationInfo::LocationExcludeBrandCountry' do
    association :location, factory: :location_info_location
    association :country, factory: :location_info_country
    brand
  end
end
