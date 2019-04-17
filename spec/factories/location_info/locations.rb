FactoryBot.define do
  factory :location_info_location, class: 'LocationInfo::Location' do
    name { "name 1" }
    address1 { "address 1" }
    address2 { "address 2" }
    address3 { "address 3" }
    city { "city" }
    state { "state" }
    country { "country" }
    postal { "postal" }
    lat { "lat" }
    lng { "lng" }
    google_map_place_id { "google map place id" }
  end
end
