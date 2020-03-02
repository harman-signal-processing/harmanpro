class InfluencersController < ApplicationController

  def new
    @influencer = Influencer.new
  end

  def create
    @influencer = Influencer.new(influencer_params)
    respond_to do |f|
      if verify_recaptcha(model: @influencer) && @influencer.save
        f.html { redirect_to thanks_influencer_path }
      else
        f.html { render action: 'new'}
      end
    end
  end

  def thanks
  end

  private

  def influencer_params
    params.require(:influencer).permit(
      :first_name,
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
      :active_networks => [],
      :type_of_content => [],
      :define_your_content => [],
      :harman_brands_for_collaborating => []
    )

  end
end
