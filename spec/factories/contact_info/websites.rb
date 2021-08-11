FactoryBot.define do
  factory :contact_info_website, class: 'ContactInfo::Website' do
    sequence(:url) {|n| "https://urltest#{n}.com"}
  end
end
