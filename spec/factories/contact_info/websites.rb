FactoryBot.define do
  factory :contact_info_website, class: 'ContactInfo::Website' do
    url { "https://urltest.com" }
  end
end