class LeadsController < ApplicationController
  http_basic_authenticate_with name: ENV['LEAD_VIEWER_NAME'], password: ENV['LEAD_VIEWER_PASSWORD'], only: [:show, :local_lookup]

  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)
    @lead.source ||= session["last_page"]
    @lead.locale ||= I18n.locale
    respond_to do |f|
      f.html { # Verify recaptcha for HTML requests
        if verify_recaptcha(model: @lead) && @lead.save
          redirect_to thankyou_path
        else
          render action: 'new'
        end
      }
    end
  end

  def show
    local_lookup
  end

  # Sometimes Acoustic API fails. In that case, the link in the leadgen
  # email directs the viewer here where we lookup the lead by the
  # id in the local database
  def local_lookup
    @lead = Lead.find(params[:id])
    @lead_followup = false
    render action: 'show'
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
      :source,
      :locale,
      :vertical_market_id)
  end
end
