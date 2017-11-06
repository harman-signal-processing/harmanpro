FactoryBot.define do
  factory :site_setting do
    sequence(:name) { |n| "MySetting#{n}" }
    content "MyText"
  end

end
