FactoryBot.define do
  factory :product_type do
    sequence(:name) {|n| "ProductType #{n}"}
  end

end
