class DistributorInfo::Admin::DistributorLocationsController < DistributorInfo::AdminController
	before_action :initialize_distributor_location, only: :create
	before_action :load_distributor_location, only: [:destroy]   
	
  # GET /distributor_info/admin/distributor_locations/new
  # GET /distributor_info/admin/distributor_locations/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @distributor_location }
    end
  end
  
  # POST /distributor_info/admin/distributor_locations
  # POST /distributor_info/admin/distributor_locations.xml
  def create
    @called_from = params[:called_from] || "distributor"
    respond_to do |format|
      if @distributor_locations.present?
        begin
          @distributor_locations.each do |distributor_location|
            begin
              distributor_location.save!
              @distributor_location = distributor_location
              add_log(user: current_user, action: "Associated #{distributor_location.distributor.name} with #{distributor_location.location.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{distributor_location.location.name}"
              format.js { render template: "/distributor_info/admin/distributor_locations/create_error" }
            end
          end  #  @distributor_locations.each do |distributor_location|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/distributor_info/admin/distributor_locations/create_error" }
        end        
      else       
          @error = "No distributor_locations provided."
          format.html { render action: "new" }
          format.xml  { render xml: @distributor_location.errors, status: :unprocessable_entity }
          format.js { render template: "/distributor_info/admin/distributor_locations/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create	  
  
  # PUT /distributor_info/admin/distributor_locations/1
  # PUT /distributor_info/admin/distributor_locations/1.xml
  def update
    respond_to do |format|
      if @distributor_location.update(distributor_location_params)
        format.html { redirect_to(admin_distributor_locations_url, notice: 'distributor location was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @distributor_location.errors, status: :unprocessable_entity }
      end
    end
  end	  
  
  def update_order
    update_list_order(DistributorInfo::DistributorLocation, params["distributor_location"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted distributor locations")
  end     
  
  # DELETE /distributor_info/admin/distributor_locations/1
  # DELETE /distributor_info/admin/distributor_locations/1.xml
  def destroy
    @called_from = params[:called_from] || "distributor"
    @distributor_location.destroy
    respond_to do |format|
      format.html { redirect_to(admin_distributor_locations_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed #{@distributor_location.location.name} from #{@distributor_location.distributor.name}")
  end   
  
  private

	  def initialize_distributor_location
      if distributor_location_params[:location_info_location_id].is_a?(Array)
        @distributor_locations = []
        distributor_id = distributor_location_params[:distributor_info_distributor_id]
        distributor_location_params[:location_info_location_id].reject(&:blank?).each do |location|
          @distributor_locations << DistributorInfo::DistributorLocation.new({distributor_info_distributor_id: distributor_id, location_info_location_id: location})
        end        
      elsif distributor_location_params[:distributor_info_distributor_id].is_a?(Array)
        @distributor_locations = []
        location_id = distributor_location_params[:location_info_location_id]
        distributor_location_params[:distributor_info_distributor_id].reject(&:blank?).each do |distributor|
          @distributor_locations << DistributorInfo::DistributorLocation.new({distributor_info_distributor_id: distributor, location_info_location_id: location_id})
        end
      end	 	    
	  end  #  def initialize_distributor_location	
  
    def load_distributor_location
      @distributor_location = DistributorInfo::DistributorLocation.find(params[:id])
    end 	
	
	  def distributor_location_params
	    params.require(:distributor_info_distributor_location).permit!
	  end   
  
end  #  class DistributorInfo::Admin::DistributorLocationsController < DistributorInfo::AdminController
