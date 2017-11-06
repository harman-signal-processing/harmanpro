FactoryBot.define do
  factory :available_locale do
    sequence(:key) {|n| "loc#{n}"}
    name "LocaleName"
  end

end
