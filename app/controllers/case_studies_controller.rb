class CaseStudiesController < ApplicationController
  before_action :redirect_old_links, only: :show

  def index
    if params[:vertical_market_id].present?
      @vertical_market = VerticalMarket.find(params[:vertical_market_id])
      @case_studies = @vertical_market.case_studies.order("created_at DESC").limit(60)
    else
      @case_studies = CaseStudy.order("created_at DESC").limit(60)
    end
  end

  def show
    @case_study = CaseStudy.find(params[:id])
  end

  private

  def redirect_old_links
    if params[:vertical_market_id].present?
      redirect_to case_study_path(params[:id]), status: 301 and return false
    end
  end

end
