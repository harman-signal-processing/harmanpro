class CaseStudiesController < ApplicationController
  require 'will_paginate/array'
  before_action :redirect_old_links, only: :show
  respond_to :html, :json, :js

  def index
    vertical_market_param = sanitize_param_value(params[:vertical_market_id],["-"]) if params[:vertical_market_id].present?
    vertical_market_param = vertical_market_param == "all" ? nil : vertical_market_param
    if vertical_market_param.present?
      @vertical_market = VerticalMarket.find(vertical_market_param)
      @case_studies = @vertical_market.case_studies.with_translations(I18n.locale)
    else
      @case_studies = CaseStudy.with_translations(I18n.locale)
    end

    # filter by asset type if requested
    pdf_case_studies = @case_studies.where("pdf_file_name != ''")
    video_case_studies = @case_studies.where("youtube_id != ''")
    @asset_type_case_study_counts = {
      pdf: pdf_case_studies.size,
      video: video_case_studies.size
    }
    @asset_type = sanitize_param_value(params[:asset_type]) if params[:asset_type].present?
    if @asset_type.present? && ["pdf","video"].include?(@asset_type)
      case @asset_type
      when "pdf"
        @case_studies = pdf_case_studies
      when "video"
        @case_studies = video_case_studies
      end
    end  #  if @asset_type.present? && ["pdf","video"].include? @asset_type

    page_num = sanitize_param_value(params[:page]).to_i if params[:page].present?
    @case_studies = @case_studies.order(Arel.sql("created_at DESC")).paginate(page: page_num, per_page: 20)

    @banner = Resource.find_by(name:"Banner: Case Studies")
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
