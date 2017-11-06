FactoryBot.define do
  factory :menu_item do
    association :locale, factory: :available_locale
    title "MyString"
    link "http://foo.com"
    new_tab false
    enabled false
  end
end
