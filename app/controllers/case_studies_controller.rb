class CaseStudiesController < ApplicationController
  before_action :redirect_old_links, only: :show
  respond_to :html, :json, :js

  def index
    if params[:vertical_market_id].present?
      @vertical_market = VerticalMarket.find(params[:vertical_market_id])
      @case_studies = @vertical_market.case_studies.with_translations(I18n.locale).order(Arel.sql("created_at DESC")).paginate(page: params[:page], per_page: 20)
    else
      @case_studies = CaseStudy.with_translations(I18n.locale).order(Arel.sql("created_at DESC")).paginate(page: params[:page], per_page: 20)
    end
    @banner_image = Resource.find_by(name:"Banner: Case Studies")
    respond_with @case_studies
  end

  def show
    @case_study = CaseStudy.find(params[:id])
    respond_with @case_study
  end

  private

  def redirect_old_links
    if params[:vertical_market_id].present?
      redirect_to case_study_path(params[:id]), status: 301 and return false
    end
  end

end
