class VerticalMarketsController < ApplicationController
  respond_to :html, :json
  after_action :track_last_page

  def show
    @vertical_market = VerticalMarket.find(params[:id])
    @lead = Lead.new(vertical_market: @vertical_market)
    respond_with @vertical_market
  end

end
