FactoryBot.define do
  factory :contact_info_phone, class: 'ContactInfo::Phone' do
    phone { "123-456-7890" }
  end
end