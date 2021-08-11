FactoryBot.define do
  factory :contact_info_data_client, class: 'ContactInfo::DataClient' do
    sequence(:name) {|n| "Data client #{n}"}
  end
end
