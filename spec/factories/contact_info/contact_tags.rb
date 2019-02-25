FactoryBot.define do
  factory :contact_info_contact_tag, class: 'ContactInfo::ContactTag' do
    position { 1 }
    contact { ContactInfo::Contact.create(name: 'Contact 1') }
    tag { ContactInfo::Tag.create(name: 'Tag 1') }
  end
end
