FactoryBot.define do
  factory :contact_info_contact_phone, class: 'ContactInfo::ContactPhone' do
    position { 1 }
    contact_info_contact { nil }
    contact_info_phone { nil }
  end
end
