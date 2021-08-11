FactoryBot.define do
  factory :location_info_location_website, class: 'LocationInfo::LocationWebsite' do
    association :location, factory: :location_info_location
    association :website, factory: :contact_info_website
    position { 1 }
  end
end
