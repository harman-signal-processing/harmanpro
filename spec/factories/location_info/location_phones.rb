FactoryBot.define do
  factory :location_info_location_phone, class: 'LocationInfo::LocationPhone' do
    association :location, factory: :location_info_location
    association :phone, factory: :contact_info_phone
    position { 1 }
  end
end
