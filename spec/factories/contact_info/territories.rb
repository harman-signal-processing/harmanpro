FactoryBot.define do
  factory :contact_info_territory, class: 'ContactInfo::Territory' do
    sequence(:name) {|n| "Territory #{n}"}
  end
end
