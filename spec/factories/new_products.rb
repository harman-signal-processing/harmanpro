FactoryBot.define do
  factory :new_product do
    name { "MyString" }
    content { "MyText" }
    image_file_name { "MyString" }
    image_content_type { "MyString" }
    image_file_size { 1 }
    image_updated_at { "2018-08-09 10:22:28" }
    released_on { "2018-08-09" }
  end
end
