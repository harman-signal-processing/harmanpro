FactoryBot.define do
  factory :contact_info_contact_phone, class: 'ContactInfo::ContactPhone' do
    position { 1 }
    association :contact, factory: :contact_info_contact
    association :phone, factory: :contact_info_phone
  end
end
