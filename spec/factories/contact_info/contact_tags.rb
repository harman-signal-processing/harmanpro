FactoryBot.define do
  factory :contact_info_contact_tag, class: 'ContactInfo::ContactTag' do
    position { 1 }
    contact_info_contact { nil }
    contact_info_tag { nil }
  end
end
