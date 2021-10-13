FactoryBot.define do
  factory :learning_session_featured_video do
    title { "featured video title" }
    youtube_id { "youtube id" }
    brand
    position { 1 }
  end
end
