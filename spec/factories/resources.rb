FactoryBot.define do
  factory :resource do
    name "ResourceName"
    attachment { File.new(Rails.root.join("spec", "fixtures", "test.jpg")) }
    resource_type "ResourceType"
    description "ResourceDescription"
  end

end
