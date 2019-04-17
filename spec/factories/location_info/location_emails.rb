FactoryBot.define do
  factory :location_info_location_email, class: 'LocationInfo::LocationEmail' do
    location { LocationInfo::Location.create(name: 'Location 1', address1:'address1', city: 'city 1', country: 'country 1') }
    email { ContactInfo::Email.create(email: 'email@test.com') }
    position { 1 }    
  end
end
