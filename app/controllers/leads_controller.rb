class LeadsController < ApplicationController

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

  private

  def lead_params
    params.require(:lead).permit(:name, :company, :email, :phone, :project_description, :location, :vertical_market_id)
  end
end
