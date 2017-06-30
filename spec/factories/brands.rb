FactoryGirl.define do
  factory :brand do
    sequence(:name) {|n| "Brand#{n}"}
    url "http://www.brand.site"
    logo { File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')) }
    white_logo { File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')) }
    tech_support_email "support@brand.com"
    parts_email "parts@brand.com"
    repair_email "repair@brand.com"
  end

end
