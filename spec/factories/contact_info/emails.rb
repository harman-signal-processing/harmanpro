FactoryBot.define do
  factory :contact_info_email, class: 'ContactInfo::Email' do
    sequence(:email) {|n| "email#{n}@email.com"}
  end
end
