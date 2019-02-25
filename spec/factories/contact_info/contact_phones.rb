FactoryBot.define do
  factory :contact_info_contact_phone, class: 'ContactInfo::ContactPhone' do
    position { 1 }
    contact { ContactInfo::Contact.create(name: 'Contact 1') }
    phone { ContactInfo::Phone.create(phone: 'Phone 1') }
  end
end
