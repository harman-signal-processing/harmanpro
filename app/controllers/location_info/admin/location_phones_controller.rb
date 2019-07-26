class LocationInfo::Admin::LocationPhonesController < LocationInfo::AdminController
	before_action :initialize_location_phone, only: :create
	before_action :load_location_phone, only: [:destroy]  
	
  # GET /location_info/admin/location_phones/new
  # GET /location_info/admin/location_phones/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @location_phone }
    end
  end		
	
  # POST /location_info/admin/location_phones
  # POST /location_info/admin/location_phones.xml
  def create
    @called_from = params[:called_from] || "location"
    respond_to do |format|
      if @location_phones.present?
        begin
          @location_phones.each do |location_phone|
            begin
              location_phone.save!
              @location_phone = location_phone
              add_log(user: current_user, action: "Associated #{location_phone.location.name} with #{location_phone.phone.phone}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{location_phone.location.name} - #{location_phone.phone.phone}"
              format.js { render template: "/location_info/admin/location_phones/create_error" }
            end
          end  #  @location_phones.each do |location_phone|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/location_info/admin/location_phones/create_error" }
        end        
      else       
          @error = "No location_phones provided."
          format.html { render action: "new" }
          format.xml  { render xml: @location_phone.errors, status: :unprocessable_entity }
          format.js { render template: "/location_info/admin/location_phones/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create	
	
  # PUT /location_info/admin/location_phones/1
  # PUT /location_info/admin/location_phones/1.xml
  def update
    respond_to do |format|
      if @location_phone.update_attributes(location_phone_params)
        format.html { redirect_to(admin_location_phones_url, notice: 'Location phone was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @location_phone.errors, status: :unprocessable_entity }
      end
    end
  end	
	
  def update_order
    update_list_order(LocationInfo::LocationPhone, params["location_phone"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted location phones")
  end		
	
  # DELETE /location_info/admin/location_phones/1
  # DELETE /location_info/admin/location_phones/1.xml
  def destroy
    @called_from = params[:called_from] || "location"
    @location_phone.destroy
    respond_to do |format|
      format.html { redirect_to(admin_location_phones_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed #{@location_phone.phone.phone} from #{@location_phone.location.name}")
  end	
	
  private

	  def initialize_location_phone
      if location_phone_params[:contact_info_phone_id].is_a?(Array)
        @location_phones = []
        location_id = location_phone_params[:location_info_location_id]
        location_phone_params[:contact_info_phone_id].reject(&:blank?).each do |phone|
          @location_phones << LocationInfo::LocationPhone.new({location_info_location_id: location_id, contact_info_phone_id: phone})
        end        
      elsif location_phone_params[:location_info_location_id].is_a?(Array)
        @location_phones = []
        phone_id = location_phone_params[:contact_info_phone_id]
        location_phone_params[:location_info_location_id].reject(&:blank?).each do |location|
          @location_phones << LocationInfo::LocationPhone.new({location_info_location_id: location, contact_info_phone_id: phone_id})
        end
      end	 	    
	  end  #  def initialize_location_phone	
	  
    def load_location_phone
      @location_phone = LocationInfo::LocationPhone.find(params[:id])
    end 	
	
	  def location_phone_params
	    params.require(:location_info_location_phone).permit!
	  end 	  
	
end  #  class LocationInfo::Admin::LocationPhonesController < LocationInfo::AdminController
