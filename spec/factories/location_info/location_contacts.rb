FactoryBot.define do
  factory :location_info_location_contact, class: 'LocationInfo::LocationContact' do
    association :location, factory: :location_info_location
    association :contact, factory: :contact_info_contact
    position { 1 }
  end
end
