class LocationInfo::Admin::LocationRegionsController < LocationInfo::AdminController
	before_action :initialize_location_region, only: :create
	before_action :load_location_region, only: [:destroy]  
	
  # GET /location_info/admin/location_regions/new
  # GET /location_info/admin/location_regions/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @location_region }
    end
  end	
	
  # POST /location_info/admin/location_regions
  # POST /location_info/admin/location_regions.xml
  def create
    @called_from = params[:called_from] || "location"
    respond_to do |format|
      if @location_regions.present?
        begin
          @location_regions.each do |location_region|
            begin
              location_region.save!
              @location_region = location_region
              # website.add_log(user: current_user, action: "Associated #{location_region.location.name} with #{location_region.region.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{location_region.region.name}"
              format.js { render template: "/location_info/admin/location_regions/create_error" }
            end
          end  #  @location_regions.each do |location_region|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/location_info/admin/location_regions/create_error" }
        end        
      else       
          @error = "No location_regions provided."
          format.html { render action: "new" }
          format.xml  { render xml: @location_region.errors, status: :unprocessable_entity }
          format.js { render template: "/location_info/admin/location_regions/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create	
	
  # PUT /location_info/admin/location_regions/1
  # PUT /location_info/admin/location_regions/1.xml
  def update
    respond_to do |format|
      if @location_region.update_attributes(location_region_params)
        format.html { redirect_to(admin_location_regions_url, notice: 'Location region was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @location_region.errors, status: :unprocessable_entity }
      end
    end
  end	
  
  def update_order
    update_list_order(LocationInfo::LocationRegion, params["location_region"]) # update_list_order is in application_controller
    head :ok
    # website.add_log(user: current_user, action: "Sorted location regions")
  end   
	
  # DELETE /location_info/admin/location_regions/1
  # DELETE /location_info/admin/location_regions/1.xml
  def destroy
    @called_from = params[:called_from] || "location"
    @location_region.destroy
    respond_to do |format|
      format.html { redirect_to(admin_location_regions_url) }
      format.xml  { head :ok }
      format.js 
    end
    # website.add_log(user: current_user, action: "Removed a region from #{@location_region.location.name}")
  end 	
	
  private

	  def initialize_location_region
      if location_region_params[:location_info_region_id].is_a?(Array)
        @location_regions = []
        location_id = location_region_params[:location_info_location_id]
        location_region_params[:location_info_region_id].reject(&:blank?).each do |region|
          @location_regions << LocationInfo::LocationRegion.new({location_info_location_id: location_id, location_info_region_id: region})
        end        
      elsif location_region_params[:location_info_location_id].is_a?(Array)
        @location_regions = []
        region_id = location_region_params[:location_info_region_id]
        location_region_params[:location_info_location_id].reject(&:blank?).each do |location|
          @location_regions << LocationInfo::LocationRegion.new({location_info_location_id: location, location_info_region_id: region_id})
        end
      end	 	    
	  end  #  def initialize_location_region	

	  
    def load_location_region
      @location_region = LocationInfo::LocationRegion.find(params[:id])
    end 	
	
	  def location_region_params
	    params.require(:location_info_location_region).permit!
	  end 
	
end  #  class LocationInfo::Admin::LocationRegionsController < LocationInfo::AdminController
