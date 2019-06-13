FactoryBot.define do
  factory :contact_info_territory_supported_country, class: 'ContactInfo::TerritorySupportedCountry' do
    territory { ContactInfo::Territory.create(name: 'Territory 1') }
    country { LocationInfo::Country.create(name: 'Country 1') }    
  end
end
