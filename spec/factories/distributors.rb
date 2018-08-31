FactoryBot.define do
  factory :distributor do
    name { "MyString" }
    country { "MyString" }
    channel_manager { "MyString" }
    contact_name { "MyString" }
    contact_phone { "MyString" }
    contact_email { "MyString" }
    time_zone { "MyString" }
    details_public { "MyText" }
    details_private { "MyText" }
    region { "MyString" }
  end
end
