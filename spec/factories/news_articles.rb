FactoryBot.define do
  factory :news_article do
    title { "MyString" }
    body { "MyText" }
    keywords { "MyText" }
    post_at { 1.week.ago }
    quote { "MyString" }
    news_photo { File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')) }
    association :locale, factory: :available_locale
  end
end
