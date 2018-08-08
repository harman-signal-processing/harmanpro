class CaseStudiesController < ApplicationController
  before_action :redirect_old_links, only: :show

  def index
    if params[:vertical_market_id].present?
      @vertical_market = VerticalMarket.find(params[:vertical_market_id])
      @case_studies = @vertical_market.case_studies.with_translations(I18n.locale).order("created_at DESC").limit(60)
    else
      @case_studies = CaseStudy.with_translations(I18n.locale).order("created_at DESC").limit(60)
    end
    @banner_image = Resource.find_by(name:"Banner: Case Studies")
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
