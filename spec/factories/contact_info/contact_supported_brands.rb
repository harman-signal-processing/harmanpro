FactoryBot.define do
  factory :contact_info_contact_supported_brand, class: 'ContactInfo::ContactSupportedBrand' do
    association :contact, factory: :contact_info_contact
    brand
    position { 1 }
  end
end
