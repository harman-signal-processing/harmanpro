FactoryBot.define do
  factory :emea_page_resource do
    emea_page
    sequence(:name) {|n| "Resource #{n}"}
    attachment { File.new(Rails.root.join("spec", "fixtures", "test.jpg")) }
    #featured false
    #link "MyString"
    #new_window false
  end
end
