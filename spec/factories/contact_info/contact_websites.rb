FactoryBot.define do
  factory :contact_info_contact_website, class: 'ContactInfo::ContactWebsite' do
    position { 1 }
    contact { ContactInfo::Contact.create(name: 'Contact 1') }
    website { ContactInfo::Website.create(url: 'url 1') }
  end
end
