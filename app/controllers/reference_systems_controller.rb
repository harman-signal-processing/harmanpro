class ReferenceSystemsController < ApplicationController
  respond_to :html, :json
  before_action :load_vertical_market
  after_action :track_last_page

  def show
    @reference_system = ReferenceSystem.find(params[:id])
    @lead = Lead.new(vertical_market: @reference_system.vertical_market)
    respond_with @vertical_market, @reference_system
  end

  private

  def load_vertical_market
    @vertical_market = VerticalMarket.find(params[:vertical_market_id])
  end
end
