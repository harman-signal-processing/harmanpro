FactoryBot.define do
  factory :influencer do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    gender { "MyString" }
    location { "MyString" }
    language { "MyString" }
    active_networks { "MyString" }
    instagram_link { "MyString" }
    instagram_followers { "MyString" }
    facebook_link { "MyString" }
    facebook_followers { "MyString" }
    twitter_link { "MyString" }
    twitter_followers { "MyString" }
    blog_link { "MyString" }
    blog_unique_monthly_visitors { "MyString" }
    audience_is_purchased { false }
    type_of_content { "MyString" }
    define_your_content { "MyString" }
    harman_brands_for_collaborating { "MyString" }
    collaboration_idea { "MyText" }
    social_media_deck_file_name { "MyString" }
    social_media_deck_content_type { "MyString" }
    social_media_deck_file_size { 1 }
    social_media_deck_updated_at { "2020-03-02 13:06:06" }
  end
end
