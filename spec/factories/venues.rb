FactoryBot.define do
  factory :venue do
    sequence(:name) {|n| "Venue#{n}"}
    description "MyText"
    left "50%"
    top "50%"
  end

end
