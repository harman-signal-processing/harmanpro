class CaseStudiesController < ApplicationController
  require 'will_paginate/array'
  before_action :redirect_old_links, only: :show
  respond_to :html, :json, :js

  def index
    vertical_market_param = params[:vertical_market_id]
    vertical_market_param = vertical_market_param == "all" ? nil : vertical_market_param
    if vertical_market_param.present?
      @vertical_market = VerticalMarket.find(vertical_market_param)
      @case_studies = @vertical_market.case_studies.with_translations(I18n.locale).order(Arel.sql("created_at DESC"))
    else
      @case_studies = CaseStudy.with_translations(I18n.locale).order(Arel.sql("created_at DESC"))
    end

    # filter by asset type if requested
    @asset_type = params[:asset_type]
    @asset_type_case_study_counts = {}
    @asset_type_case_study_counts[:pdf] = @case_studies.select{|cs| cs.pdf_url.present?}.count
    @asset_type_case_study_counts[:video] = @case_studies.select{|cs| cs.youtube_id.present?}.count
    if @asset_type.present? && ["pdf","video"].include?(@asset_type)
      case @asset_type
      when "pdf"
        @case_studies = @case_studies.select{|cs| cs.pdf_url.present?}
      when "video"
        @case_studies = @case_studies.select{|cs| cs.youtube_id.present?}
      end
    end  #  if @asset_type.present? && ["pdf","video"].include? @asset_type

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
