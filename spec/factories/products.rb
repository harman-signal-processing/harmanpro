FactoryBot.define do

  factory :product do
    sequence(:name) {|n| "Product #{n}" }
    url { "http://some.where.com/product.htm" }
    brand
  end

end
