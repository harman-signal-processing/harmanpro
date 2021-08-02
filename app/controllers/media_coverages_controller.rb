class MediaCoveragesController < ApplicationController
  require 'will_paginate/array'
  respond_to :html, :json, :js

  def index
    if params[:brand_id].present?
      @brand = Brand.find(params[:brand_id])
      @media_coverages = @brand.media_coverages.live
    else
      @media_coverages = MediaCoverage.live
    end

    @media_coverages = @media_coverages.paginate(page: params[:page], per_page: 24)
  end

end
