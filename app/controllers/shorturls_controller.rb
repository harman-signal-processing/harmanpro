class ShorturlsController < ApplicationController
  def show
    @short_url = Shorturl.where(shortcut: params[:shorturl]).first
    redirect_to @short_url.full_url, status: 301
  end
end
