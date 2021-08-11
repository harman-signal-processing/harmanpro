FactoryBot.define do
  factory :contact_info_contact_email, class: 'ContactInfo::ContactEmail' do
    position { 1 }
    association :contact, factory: :contact_info_contact
    association :email, factory: :contact_info_email
  end
end
