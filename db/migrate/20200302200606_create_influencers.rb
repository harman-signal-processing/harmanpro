class CreateInfluencers < ActiveRecord::Migration[5.2]
  def change
    create_table :influencers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :gender
      t.string :location
      t.string :language
      t.string :active_networks
      t.string :instagram_link
      t.string :instagram_followers
      t.string :facebook_link
      t.string :facebook_followers
      t.string :twitter_link
      t.string :twitter_followers
      t.string :blog_link
      t.string :blog_unique_monthly_visitors
      t.boolean :audience_is_purchased
      t.string :type_of_content
      t.string :define_your_content
      t.string :harman_brands_for_collaborating
      t.text :collaboration_idea
      t.string :social_media_deck_file_name
      t.string :social_media_deck_content_type
      t.integer :social_media_deck_file_size
      t.datetime :social_media_deck_updated_at

      t.timestamps
    end
  end
end
