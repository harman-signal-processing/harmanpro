FactoryBot.define do
  factory :contact_info_contact_supported_brand, class: 'ContactInfo::ContactSupportedBrand' do
    contact { ContactInfo::Contact.create(name: 'Contact 1') }
    brand { Brand.create(name: 'Brand 1', url: 'https://www.brand.com') }
    position { 1 }     
  end
end
