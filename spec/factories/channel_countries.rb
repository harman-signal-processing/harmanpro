FactoryBot.define do
  factory :channel_country do
    sequence(:name) {|n| "Channel#{n}"}
  end
end
