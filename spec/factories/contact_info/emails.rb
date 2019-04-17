FactoryBot.define do
  factory :contact_info_email, class: 'ContactInfo::Email' do
    email { "Email 1" }
  end
end