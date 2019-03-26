class LocationInfo::Admin::LocationContactsController < LocationInfo::AdminController
	before_action :initialize_location_contact, only: :create
	before_action :load_location_contact, only: [:destroy]   
	
  # GET /location_info/admin/location_contacts/new
  # GET /location_info/admin/location_contacts/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @location_contact }
    end
  end	
	
  # POST /location_info/admin/location_contacts
  # POST /location_info/admin/location_contacts.xml
  def create
    @called_from = params[:called_from] || "location"
    respond_to do |format|
      if @location_contacts.present?
        begin
          @location_contacts.each do |location_contact|
            begin
              location_contact.save!
              @location_contact = location_contact
              # website.add_log(user: current_user, action: "Associated #{location_contact.location.name} with #{location_contact.contact.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{location_contact.location.name}"
              format.js { render template: "/location_info/admin/location_contacts/create_error" }
            end
          end  #  @location_contacts.each do |location_contact|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/location_info/admin/location_contacts/create_error" }
        end        
      else       
          @error = "No location_contacts provided."
          format.html { render action: "new" }
          format.xml  { render xml: @location_contact.errors, status: :unprocessable_entity }
          format.js { render template: "/location_info/admin/location_contacts/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create	
	
  # PUT /location_info/admin/location_contacts/1
  # PUT /location_info/admin/location_contacts/1.xml
  def update
    respond_to do |format|
      if @location_contact.update_attributes(location_contact_params)
        format.html { redirect_to(admin_location_contacts_url, notice: 'Location contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @location_contact.errors, status: :unprocessable_entity }
      end
    end
  end		
	
  def update_order
    update_list_order(LocationInfo::LocationContact, params["location_contact"]) # update_list_order is in application_controller
    head :ok
    # website.add_log(user: current_user, action: "Sorted location contacts")
  end   	
	
  # DELETE /location_info/admin/location_contacts/1
  # DELETE /location_info/admin/location_contacts/1.xml
  def destroy
    @called_from = params[:called_from] || "location"
    @location_contact.destroy
    respond_to do |format|
      format.html { redirect_to(admin_location_contacts_url) }
      format.xml  { head :ok }
      format.js 
    end
    # website.add_log(user: current_user, action: "Removed a contact from #{@location_contact.location.name}")
  end 	
	
  private

	  def initialize_location_contact
      if location_contact_params[:contact_info_contact_id].is_a?(Array)
        @location_contacts = []
        location_id = location_contact_params[:location_info_location_id]
        location_contact_params[:contact_info_contact_id].reject(&:blank?).each do |contact|
          @location_contacts << LocationInfo::LocationContact.new({location_info_location_id: location_id, contact_info_contact_id: contact})
        end        
      elsif location_contact_params[:location_info_location_id].is_a?(Array)
        @location_contacts = []
        contact_id = location_contact_params[:contact_info_contact_id]
        location_contact_params[:location_info_location_id].reject(&:blank?).each do |location|
          @location_contacts << LocationInfo::LocationContact.new({location_info_location_id: location, contact_info_contact_id: contact_id})
        end
      end	 	    
	  end  #  def initialize_location_contact	
	
    def load_location_contact
      @location_contact = LocationInfo::LocationContact.find(params[:id])
    end 	
	
	  def location_contact_params
	    params.require(:location_info_location_contact).permit!
	  end 	
	
end  #  class LocationInfo::Admin::LocationContactsController < LocationInfo::AdminController
