FactoryBot.define do
  factory :contact_info_contact_supported_country, class: 'ContactInfo::ContactSupportedCountry' do
    association :contact, factory: :contact_info_contact
    association :country, factory: :location_info_country
    position { 1 }
  end
end
