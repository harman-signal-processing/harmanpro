FactoryBot.define do
  factory :contact_info_contact_email, class: 'ContactInfo::ContactEmail' do
    position { 1 }
    contact { ContactInfo::Contact.create(name: 'Contact 1') }
    email { ContactInfo::Email.create(email: 'Email 1') }
  end
end
