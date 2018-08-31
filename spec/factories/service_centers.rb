FactoryBot.define do
  factory :service_center do
    contact_name { "Joe" }
    sequence(:name) { |n| "ServiceCenter ##{n}" }
    zip { "90210" }
    email { "email@email.com" }
    willingness { "1" }
  end

end
