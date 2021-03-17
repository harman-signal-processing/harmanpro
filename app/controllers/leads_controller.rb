class LeadsController < ApplicationController
  http_basic_authenticate_with name: ENV['LEAD_VIEWER_NAME'], password: ENV['LEAD_VIEWER_PASSWORD'], only: :show

  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)
    @lead.source = session["last_page"]
    @lead.locale = I18n.locale
    respond_to do |f|
      if verify_recaptcha(model: @lead) && @lead.save
        f.html { redirect_to thankyou_path }
        f.json { head :ok }
      else
        f.html { render action: 'new'}
        f.json { head :error }
      end
    end
  end

  # The show method here doesn't actually use the local lead database.
  # Instead, it uses the goacoustic gem to pull contact info.
  def show
    @lead = Lead.retrieve_remote(params[:id])
    @lead_followup = LeadFollowup.new(recipient_id: @lead.recipient_id)
    if cookies[:initials].present?
      @lead_followup.initials = cookies[:initials]
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
      :vertical_market_id)
  end
end
