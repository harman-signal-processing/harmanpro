FactoryBot.define do
  factory :location_info_location_email, class: 'LocationInfo::LocationEmail' do
    association :location, factory: :location_info_location
    association :email, factory: :contact_info_email
    position { 1 }
  end
end
