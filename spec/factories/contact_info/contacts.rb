FactoryBot.define do
  factory :contact_info_contact, class: 'ContactInfo::Contact' do
    sequence(:name) {|n| "Contact #{n}"}
  end
end
