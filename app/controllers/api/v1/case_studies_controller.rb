module Api
  module V1
    class CaseStudiesController < ApplicationController
        respond_to :xml, :json, :html
        layout "minimal"
        
        def show
            brand_param = params[:brand]
            brand = Brand.find_by_name(brand_param)
              
            respond_with brand.case_studies.order(created_at: :desc).as_json(
              include: { 
                translations: {},
                vertical_markets: {}
              },
              methods: [:banner_urls,:pdf_url,:youtube_info])  #  respond_with brand.case_studies.as_json(
              
        end  #  def show
    end  #  class CaseStudiesController < ApplicationController
  end  #  module V1
end  #  module Api