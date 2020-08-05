class LocationInfo::Admin::LocationEmailsController < LocationInfo::AdminController
	before_action :initialize_location_email, only: :create
	before_action :load_location_email, only: [:destroy]
	
  # GET /location_info/admin/location_emails/new
  # GET /location_info/admin/location_emails/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @location_email }
    end
  end	
	
  # POST /location_info/admin/location_emails
  # POST /location_info/admin/location_emails.xml
  def create
    @called_from = params[:called_from] || "location"
    respond_to do |format|
      if @location_emails.present?
        begin
          @location_emails.each do |location_email|
            begin
              location_email.save!
              @location_email = location_email
              add_log(user: current_user, action: "Associated #{location_email.location.name} with #{location_email.email.email}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{location_email.location.name} - #{location_email.email.email}"
              format.js { render template: "/location_info/admin/location_emails/create_error" }
            end
          end  #  @location_emails.each do |location_email|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/location_info/admin/location_emails/create_error" }
        end        
      else       
          @error = "No location_emails provided."
          format.html { render action: "new" }
          format.xml  { render xml: @location_email.errors, status: :unprocessable_entity }
          format.js { render template: "/location_info/admin/location_emails/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create	
	
  # PUT /location_info/admin/location_emails/1
  # PUT /location_info/admin/location_emails/1.xml
  def update
    respond_to do |format|
      if @location_email.update(location_email_params)
        format.html { redirect_to(admin_location_emails_url, notice: 'Location email was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @location_email.errors, status: :unprocessable_entity }
      end
    end
  end		
	
  def update_order
    update_list_order(LocationInfo::LocationEmail, params["location_email"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted location emails")
  end	
	
  # DELETE /location_info/admin/location_emails/1
  # DELETE /location_info/admin/location_emails/1.xml
  def destroy
    @called_from = params[:called_from] || "location"
    @location_email.destroy
    respond_to do |format|
      format.html { redirect_to(admin_location_emails_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed #{@location_email.email.email} from #{@location_email.location.name}")
  end 	
	
  private

	  def initialize_location_email
      if location_email_params[:contact_info_email_id].is_a?(Array)
        @location_emails = []
        location_id = location_email_params[:location_info_location_id]
        location_email_params[:contact_info_email_id].reject(&:blank?).each do |email|
          @location_emails << LocationInfo::LocationEmail.new({location_info_location_id: location_id, contact_info_email_id: email})
        end        
      elsif location_email_params[:location_info_location_id].is_a?(Array)
        @location_emails = []
        email_id = location_email_params[:contact_info_email_id]
        location_email_params[:location_info_location_id].reject(&:blank?).each do |location|
          @location_emails << LocationInfo::LocationEmail.new({location_info_location_id: location, contact_info_email_id: email_id})
        end
      end	 	    
	  end  #  def initialize_location_email
	  
    def load_location_email
      @location_email = LocationInfo::LocationEmail.find(params[:id])
    end 	
	
	  def location_email_params
	    params.require(:location_info_location_email).permit!
	  end 	  
	
end  #  class LocationInfo::Admin::LocationEmailsController < LocationInfo::AdminController
