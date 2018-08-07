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
    if @vertical_market.live? || special_access_granted?(@vertical_market)
      respond_with @vertical_market
    else
      redirect_to vertical_markets_path and return false
    end
  end

end
