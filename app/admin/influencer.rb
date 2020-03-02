ActiveAdmin.register Influencer do
  menu label: "Influencers"
  actions :all, except: [:new, :create]
  permit_params :first_name,
      :last_name,
      :email,
      :gender,
      :location,
      :language,
      :instagram_link,
      :instagram_followers,
      :facebook_link,
      :facebook_followers,
      :twitter_link,
      :twitter_followers,
      :blog_link,
      :blog_unique_monthly_visitors,
      :audience_is_purchased,
      :social_media_deck,
      :collaboration_idea,
      :active_networks,
      :type_of_content,
      :define_your_content,
      :harman_brands_for_collaborating

  index do
    id_column
    column :first_name
    column :last_name
    column :email
    column :active_networks
  end

  filter :location
  filter :active_networks
  filter :harman_brands_for_collaborating

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :gender
      row :location
      row :language
      row :active_networks
      row :instagram_link
      row :instagram_followers
      row :facebook_link
      row :facebook_followers
      row :twitter_link
      row :twitter_followers
      row :blog_link
      row :blog_unique_monthly_visitors
      row :audience_is_purchased
      row :social_media_deck do
        if influencer.social_media_deck_file_name.present?
          link_to(influencer.social_media_deck_file_name, influencer.social_media_deck.url)
        end
      end
      row :type_of_content
      row :define_your_content
      row :harman_brands_for_collaborating
      row :collaboration_idea
    end
  end

end
