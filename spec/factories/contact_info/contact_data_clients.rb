FactoryBot.define do
  factory :contact_info_contact_data_client, class: 'ContactInfo::ContactDataClient' do
    position { 1 }
    association :contact, factory: :contact_info_contact
    association :data_client, factory: :contact_info_data_client
  end
end
