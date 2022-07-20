class SocialMediaController < ApplicationController
  def facebook
    redirect_to SiteSetting.value("facebook_link"), allow_other_host: true
  end
  
  def twitter
    redirect_to SiteSetting.value("twitter_link"), allow_other_host: true
  end
  
  def linkedin
    redirect_to SiteSetting.value("linkedin_link"), allow_other_host: true
  end
  
  def youtube
    redirect_to SiteSetting.value("youtube_link"), allow_other_host: true
  end
  
  def pinterest
    redirect_to SiteSetting.value("pinterest_link"), allow_other_host: true
  end
  
  def google
    redirect_to SiteSetting.value("google_link"), allow_other_host: true
  end
  
  def instagram
    redirect_to SiteSetting.value("instagram_link"), allow_other_host: true
  end
  
end  #  class SocialMediaController < ApplicationController
