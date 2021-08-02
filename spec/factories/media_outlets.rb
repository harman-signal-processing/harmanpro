FactoryBot.define do
  factory :media_outlet do
    sequence(:name) {|n| "MediaOutlet#{n}"}
    logo { File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')) }
  end
end
