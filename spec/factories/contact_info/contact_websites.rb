FactoryBot.define do
  factory :contact_info_contact_website, class: 'ContactInfo::ContactWebsite' do
    position { 1 }
    association :contact, factory: :contact_info_contact
    association :website, factory: :contact_info_website
  end
end
