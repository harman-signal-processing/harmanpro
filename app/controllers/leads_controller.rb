class LeadsController < ApplicationController

  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)
    @lead.source = session["last_page"]
    respond_to do |f|
      if @lead.save
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
    params.require(:lead).permit(:name, :company, :email, :phone, :project_description)
  end
end
