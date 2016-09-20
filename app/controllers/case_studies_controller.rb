class CaseStudiesController < ApplicationController
  before_action :redirect_old_links

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
