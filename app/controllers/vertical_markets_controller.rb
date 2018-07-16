class VerticalMarketsController < ApplicationController
  respond_to :html, :json
  after_action :track_last_page

  def index
    @vertical_markets = VerticalMarket.active
    respond_with @vertical_markets do |format|
      format.html {
        template = LandingPage.where(slug: "solutions")
        if template.exists?
          render_landing_page("solutions") and return false
        end
      }
      format.json
    end
  end

  def show
    @vertical_market = VerticalMarket.find(params[:id])
    @lead = Lead.new(vertical_market: @vertical_market)
    if @vertical_market.live? || special_access_granted?
      respond_with @vertical_market
    else
      redirect_to vertical_markets_path and return false
    end
  end

  def special_access_granted?
    preview_code_provided? || admin_logged_in?
  end

  def admin_logged_in?
    user_signed_in? && (current_user.admin_access? || curent_user.cms_user?)
  end

  def preview_code_provided?
    @vertical_market.preview_code.present? && params[:preview_code] == @vertical_market.preview_code
  end

end
