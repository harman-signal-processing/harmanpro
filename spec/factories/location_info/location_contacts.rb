FactoryBot.define do
  factory :location_info_location_contact, class: 'LocationInfo::LocationContact' do
    location { LocationInfo::Location.create(name: 'Location 1', address1:'address1', city: 'city 1', country: 'country 1') }
    contact { ContactInfo::Contact.create(name: 'Contact 1') }
    position { 1 }
  end
end
