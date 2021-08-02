FactoryBot.define do
  factory :media_coverage do
    media_outlet
    headline { "MyString" }
    link { "https://MyString" }
  end
end
