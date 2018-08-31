FactoryBot.define do
  factory :artist do
    name { "MyString" }
    description { "MyText" }
    overview { "MyText" }
    photo { File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')) }
    association :locale, factory: :available_locale
  end
end
