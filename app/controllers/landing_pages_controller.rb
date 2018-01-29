class LandingPagesController < ApplicationController

  def show
    # Strip out random strings at the end of the URL. These started showing
    # up for the connected-pa website.
    if params[:random]
      redirect_to landing_page_path(params[:id]), status: 301 and return false
    end
    render_landing_page(params[:id])
  end

  def contacts_home
    if LandingPage.exists?(slug: "contact-us-test")
      @landing_page = LandingPage.find("contact-us-test")
      render action: :show and return false
    else
      redirect_to "https://pro.harman.com" and return false
    end
  end

  def contacts_solutions
    if LandingPage.exists?(slug: "solutions-contacts")
      @landing_page = LandingPage.find("solutions-contacts")
      render action: :show and return false
    else
      redirect_to "https://pro.harman.com" and return false
    end
  end

  def contacts_channel_map
    if LandingPage.exists?(slug: "contactsmap")
      @landing_page = LandingPage.find("contactsmap")
      render action: :show and return false
    else
      redirect_to "https://pro.harman.com" and return false
    end
  end

  def brand_contacts
  end

  def training
  end

  def privacy_policy
    if LandingPage.exists?(slug: "privacy-policy")
      @landing_page = LandingPage.find("privacy-policy")
      render action: :show and return false
    else
      redirect_to "http://www.harman.com" and return false
    end
  end

  def terms_of_use
    if LandingPage.exists?(slug: "terms-of-use")
      @landing_page = LandingPage.find("terms-of-use")
      render action: :show and return false
    else
      redirect_to "http://www.harman.com" and return false
    end
  end

  def thankyou
  end

  def thanks
  end

end
