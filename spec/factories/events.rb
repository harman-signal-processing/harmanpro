FactoryBot.define do
  factory :event do
    sequence(:name) {|n| "Event #{n}"}
    start_on 1.day.from_now
    end_on 2.days.from_now
    description "MyText"
    featured false
    active false
  end

end
