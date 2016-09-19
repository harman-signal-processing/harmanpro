class FinanceController < ApplicationController
  def index
    if LandingPage.exists?(slug: 'finance')
      render_landing_page('finance')
    elsif LandingPage.exists?(slug: 'financing')
      render_landing_page('financing')
    else
      render_landing_page('harman-equipment-financing')
    end
  end
end
