FactoryBot.define do
  factory :case_study_image do
    case_study
    image { File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')) }
  end
end
