class FinanceController < ApplicationController
  def index
    render_landing_page('finance')
  end
end
