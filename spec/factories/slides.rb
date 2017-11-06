FactoryBot.define do
  factory :slide do
    name "MyString"
    association :locale, factory: :available_locale
    background { File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')) }
    bubble { File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')) }
    headline "MyString"
    description "MyString"
    link_text "MyString"
    link_url "MyString"
    link_new_window false
    start_on 1.week.ago
    end_on 1.week.from_now
  end
end
