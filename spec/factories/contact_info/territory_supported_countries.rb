FactoryBot.define do
  factory :contact_info_territory_supported_country, class: 'ContactInfo::TerritorySupportedCountry' do
    association :territory, factory: :contact_info_territory
    association :country, factory: :location_info_country
  end
end
