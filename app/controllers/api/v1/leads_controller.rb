module Api
  module V1
    class LeadsController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        @lead = Lead.new(lead_params)
        @lead.source ||= session["last_page"]
        @lead.locale ||= I18n.locale
        respond_to do |f|
          if @lead.save
            f.json { head :ok }
          else
            f.json { head :error }
          end
        end
      end

      private

      def lead_params
        params.require(:lead).permit(
          :name,
          :company,
          :email,
          :phone,
          :city,
          :state,
          :country,
          :project_description,
          :subscribe,
          :source)
      end

    end
  end
end


