FactoryBot.define do
  factory :emea_page do
    sequence(:title) {|n| "EmeaPage #{n}"}
    highlight_color { "#CCFF00" }
    publish_on { 2.weeks.ago }
    content { "MyText" }
  end
end
