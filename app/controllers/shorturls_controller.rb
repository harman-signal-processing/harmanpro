class ShorturlsController < ApplicationController
  def show
    if Shorturl.exists?(shortcut: params[:shorturl])
      @short_url = Shorturl.where(shortcut: params[:shorturl]).first
      redirect_to @short_url.full_url, status: 301, allow_other_host: true
    elsif LandingPage.exists?(slug: params[:shorturl].downcase)
      redirect_to LandingPage.find(params[:shorturl].downcase)
    else
      redirect_to root_path
    end
  end
end
