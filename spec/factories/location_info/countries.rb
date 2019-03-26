FactoryBot.define do
  factory :location_info_country, class: 'LocationInfo::Country' do
    name { "United States of America" }
    harman_name { "United States of America" }
    alpha2 { "US" }
    alpha3 { "USA" }
    continent { "North America" }
    region { "Americas" }
    sub_region { "Northern America" }
    world_region { "AMER" }
    harman_world_region { "AMER" }
    calling_code { 1 }
    numeric_code { 840 }
  end
end
