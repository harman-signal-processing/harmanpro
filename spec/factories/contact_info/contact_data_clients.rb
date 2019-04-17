FactoryBot.define do
  factory :contact_info_contact_data_client, class: 'ContactInfo::ContactDataClient' do
    position { 1 }
    contact { ContactInfo::Contact.create(name: 'Contact 1') }
    data_client { ContactInfo::DataClient.create(name: 'Data client 1') }
  end
end
