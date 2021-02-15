class LeadFollowupsController < ApplicationController
  http_basic_authenticate_with name: ENV['LEAD_VIEWER_NAME'], password: ENV['LEAD_VIEWER_PASSWORD']

  def create
    @lead_followup = LeadFollowup.new(lead_followup_params)
    respond_to do |f|
      if @lead_followup.save
        f.html { redirect_to lead_path(@lead_followup.recipient_id), notice: "Note was saved." }
        f.js
      else
        f.html { redirect_to lead_path(@lead_followup.recipient_id), alert: "Problem saving note." }
        f.js { render template: "create_error" }
      end
    end
  end

  def destroy
    @lead_followup = LeadFollowup.find(params[:id])
    @lead_followup.destroy!
    respond_to do |f|
      f.html { redirect_to lead_path(@lead_followup.recipient_id), notice: "Note was deleted." }
      f.js
    end
  end

  private

  def lead_followup_params
    params.require(:lead_followup).permit(:recipient_id, :note)
  end
end
