FactoryBot.define do
  factory :contact_info_contact_email, class: 'ContactInfo::ContactEmail' do
    position { 1 }
    Contact { nil }
    Email { nil }
  end
end
