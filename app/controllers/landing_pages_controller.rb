class LandingPagesController < ApplicationController

  def show
    # Strip out random strings at the end of the URL. These started showing
    # up for the connected-pa website.
    if params[:random]
      redirect_to landing_page_path(params[:id]), status: 301 and return false
    end
    render_landing_page(params[:id])
  end

  def training
  end

  def privacy_policy
    if LandingPage.exists?(slug: "privacy-policy")
      @landing_page = LandingPage.find("privacy-policy")
      render action: :show and return false
    else
      redirect_to "http://www.harman.com/privacy-policy", allow_other_host: true and return false
    end
  end

  def terms_of_use
    if LandingPage.exists?(slug: "terms-of-use")
      @landing_page = LandingPage.find("terms-of-use")
      render action: :show and return false
    else
      redirect_to "http://www.harman.com/terms-use", allow_other_host: true and return false
    end
  end

  def thankyou
  end

  def thanks
  end

end
