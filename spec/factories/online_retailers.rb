FactoryBot.define do
  factory :online_retailer do
    sequence(:name) {|n| "Retailer#{n}" }
    sequence(:url) {|n| "http://retailer#{n}.lvh.me" }
    logo { File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')) }
    association :locale, factory: :available_locale
  end

end
