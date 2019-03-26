FactoryBot.define do
  factory :location_info_location_website, class: 'LocationInfo::LocationWebsite' do
    location { LocationInfo::Location.create(name: 'Location 1', address1:'address1', city: 'city 1', country: 'country 1') }
    website { ContactInfo::Website.create(url: 'https://pro.harman.com') }
    position { 1 }    
  end
end
