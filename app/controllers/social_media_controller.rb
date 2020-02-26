class SocialMediaController < ApplicationController
  def facebook
    redirect_to SiteSetting.value("facebook_link")
  end
  
  def twitter
    redirect_to SiteSetting.value("twitter_link")
  end
  
  def linkedin
    redirect_to SiteSetting.value("linkedin_link")
  end
  
  def youtube
    redirect_to SiteSetting.value("youtube_link")
  end
  
  def pinterest
    redirect_to SiteSetting.value("pinterest_link")
  end
  
  def google
    redirect_to SiteSetting.value("google_link")
  end
  
  def instagram
    redirect_to SiteSetting.value("instagram_link")
  end
  
end  #  class SocialMediaController < ApplicationController