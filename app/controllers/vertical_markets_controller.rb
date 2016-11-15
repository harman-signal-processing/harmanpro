class VerticalMarketsController < ApplicationController
  respond_to :html, :json
  after_action :track_last_page

  def index
    @vertical_markets = VerticalMarket.active
    respond_with @vertical_markets do |format|
      format.html { redirect_to root_path and return false }
      format.json
    end
  end

  def show
    @vertical_market = VerticalMarket.find(params[:id])
    @lead = Lead.new(vertical_market: @vertical_market)
    respond_with @vertical_market
  end

end
