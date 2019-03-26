class LocationInfo::Admin::LocationWebsitesController < LocationInfo::AdminController
  before_action :initialize_location_website, only: :create
	before_action :load_location_website, only: [:destroy]
	
  # GET /location_info/admin/location_websites/new
  # GET /location_info/admin/location_websites/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @location_website }
    end
  end	
  
  # POST /location_info/admin/location_websites
  # POST /location_info/admin/location_websites.xml
  def create
    @called_from = params[:called_from] || "location"
    respond_to do |format|
      if @location_websites.present?
        begin
          @location_websites.each do |location_website|
            begin
              location_website.save!
              @location_website = location_website
              # website.add_log(user: current_user, action: "Associated #{location_website.location.name} with #{location_website.website.url}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{location_website.location.name} - #{location_website.website.url}"
              format.js { render template: "/location_info/admin/location_websites/create_error" }
            end
          end  #  @location_websites.each do |location_website|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/location_info/admin/location_websites/create_error" }
        end        
      else       
          @error = "No location_websites provided."
          format.html { render action: "new" }
          format.xml  { render xml: @location_website.errors, status: :unprocessable_entity }
          format.js { render template: "/location_info/admin/location_websites/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create  
  
  # PUT /location_info/admin/location_websites/1
  # PUT /location_info/admin/location_websites/1.xml
  def update
    respond_to do |format|
      if @location_website.update_attributes(location_website_params)
        format.html { redirect_to(admin_location_websites_url, notice: 'Location website was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @location_website.errors, status: :unprocessable_entity }
      end
    end
  end	  
  
  def update_order
    update_list_order(LocationInfo::LocationWebsite, params["location_website"]) # update_list_order is in application_controller
    head :ok
    # website.add_log(user: current_user, action: "Sorted location websites")
  end	  
  
  # DELETE /location_info/admin/location_websites/1
  # DELETE /location_info/admin/location_websites/1.xml
  def destroy
    @called_from = params[:called_from] || "location"
    @location_website.destroy
    respond_to do |format|
      format.html { redirect_to(admin_location_websites_url) }
      format.xml  { head :ok }
      format.js 
    end
    # website.add_log(user: current_user, action: "Removed a website from #{@location_website.location.name}")
  end	  
  
	  def initialize_location_website
      if location_website_params[:contact_info_website_id].is_a?(Array)
        @location_websites = []
        location_id = location_website_params[:location_info_location_id]
        location_website_params[:contact_info_website_id].reject(&:blank?).each do |website|
          @location_websites << LocationInfo::LocationWebsite.new({location_info_location_id: location_id, contact_info_website_id: website})
        end        
      elsif location_website_params[:location_info_location_id].is_a?(Array)
        @location_websites = []
        website_id = location_website_params[:contact_info_website_id]
        location_website_params[:location_info_location_id].reject(&:blank?).each do |location|
          @location_websites << LocationInfo::LocationWebsite.new({location_info_location_id: location, contact_info_website_id: website_id})
        end
      end	 	    
	  end  #  def initialize_location_website  
  
    def load_location_website
      @location_website = LocationInfo::LocationWebsite.find(params[:id])
    end 	
	
	  def location_website_params
	    params.require(:location_info_location_website).permit!
	  end   
  
end  #  class LocationInfo::Admin::LocationWebsitesController < LocationInfo::AdminController
