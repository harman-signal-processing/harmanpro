FactoryBot.define do
  factory :contact_info_contact_supported_country, class: 'ContactInfo::ContactSupportedCountry' do
    contact { ContactInfo::Contact.create(name: 'Contact 1') }
    country { LocationInfo::Country.create(name: 'Country 1', harman_name: 'Country 1') }
    position { 1 }     
  end
end
