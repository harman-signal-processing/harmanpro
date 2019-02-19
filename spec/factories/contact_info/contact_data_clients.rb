FactoryBot.define do
  factory :contact_info_contact_data_client, class: 'ContactInfo::ContactDataClient' do
    position { 1 }
    contact_info_contact { nil }
    contact_info_data_client { nil }
  end
end
