FactoryBot.define do
  factory :location_info_location_region, class: 'LocationInfo::LocationRegion' do
    association :location, factory: :location_info_location
    association :region, factory: :location_info_region
    position { 1 }
  end
end
