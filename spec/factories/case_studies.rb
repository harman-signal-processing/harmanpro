FactoryBot.define do
  factory :case_study do
    sequence(:headline) {|n| "CS Headline##{n}" }
    description "CS Description"
    banner { File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')) }
    content "CS Content"
  end

end
