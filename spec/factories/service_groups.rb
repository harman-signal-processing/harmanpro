FactoryBot.define do
  factory :service_group do
    sequence(:name) { |n| "ServiceGroup##{n}" }
    brand
  end

end
