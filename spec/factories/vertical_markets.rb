FactoryBot.define do
  factory :vertical_market do
    sequence(:name) {|n| "Vertical Market#{n}"}
    headline { "Vertical Market Headline" }
    #parent_id 1
  end

end
