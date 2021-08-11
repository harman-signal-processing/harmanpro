FactoryBot.define do
  factory :contact_info_contact_tag, class: 'ContactInfo::ContactTag' do
    position { 1 }
    association :contact, factory: :contact_info_contact
    association :tag, factory: :contact_info_tag
  end
end
