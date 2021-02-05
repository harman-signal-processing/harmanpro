module Api
  module V1
    class CaseStudiesController < ApplicationController
      respond_to :xml, :json, :html
      layout "minimal"

      def show
        brand_param = params[:brand]
        brand = Brand.find_by_name(brand_param)

        respond_to do |format|
          if brand.present?
            @case_studies = brand.case_studies.order(created_at: :desc)
            format.html
            format.xml { render xml: @case_studies }
            format.json { respond_with @case_studies }
          else
            format.html { render plain: "Not found" }
            format.xml { render xml: [] }
            format.json { render :json => {"case_studies":[]} }
          end
        end
      end

    end
  end
end
