FactoryBot.define do
  factory :location_info_location_phone, class: 'LocationInfo::LocationPhone' do
    location { LocationInfo::Location.create(name: 'Location 1', address1:'address1', city: 'city 1', country: 'country 1') }
    phone { ContactInfo::Phone.create(phone: '123 456-7890') }
    position { 1 }     
  end
end
