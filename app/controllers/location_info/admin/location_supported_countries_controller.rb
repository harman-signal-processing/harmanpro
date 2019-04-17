class LocationInfo::Admin::LocationSupportedCountriesController < LocationInfo::AdminController
	before_action :initialize_location_supported_country, only: :create
	before_action :load_location_supported_country, only: [:destroy]   
	
  # GET /location_info/admin/location_supported_countries/new
  # GET /location_info/admin/location_supported_countries/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @location_supported_country }
    end
  end
  
  # POST /location_info/admin/location_supported_countries
  # POST /location_info/admin/location_supported_countries.xml
  def create
    @called_from = params[:called_from] || "location"
    respond_to do |format|
      if @location_supported_countries.present?
        begin
          @location_supported_countries.each do |location_supported_country|
            begin
              location_supported_country.save!
              @location_supported_country = location_supported_country
              # website.add_log(user: current_user, action: "Associated #{location_supported_country.location.name} with #{location_supported_country.supported_country.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{location_supported_country.country.name}"
              format.js { render template: "/location_info/admin/location_supported_countries/create_error" }
            end
          end  #  @location_supported_countries.each do |location_supported_country|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/location_info/admin/location_supported_countries/create_error" }
        end        
      else       
          @error = "No location_supported_countries provided."
          format.html { render action: "new" }
          format.xml  { render xml: @location_supported_country.errors, status: :unprocessable_entity }
          format.js { render template: "/location_info/admin/location_supported_countries/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create  
  
  # PUT /location_info/admin/location_supported_countries/1
  # PUT /location_info/admin/location_supported_countries/1.xml
  def update
    respond_to do |format|
      if @location_supported_country.update_attributes(location_supported_country_params)
        format.html { redirect_to(admin_location_supported_countries_url, notice: 'Location supported_country was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @location_supported_country.errors, status: :unprocessable_entity }
      end
    end
  end  
  
  def update_order
    update_list_order(LocationInfo::LocationSupportedCountry, params["location_supported_country"]) # update_list_order is in application_controller
    head :ok
    # website.add_log(user: current_user, action: "Sorted location supported_countries")
  end    
  
  # DELETE /location_info/admin/location_supported_countries/1
  # DELETE /location_info/admin/location_supported_countries/1.xml
  def destroy
    @called_from = params[:called_from] || "location"
    @location_supported_country.destroy
    respond_to do |format|
      format.html { redirect_to(admin_location_supported_countries_url) }
      format.xml  { head :ok }
      format.js 
    end
    # website.add_log(user: current_user, action: "Removed a supported_country from #{@location_supported_country.location.name}")
  end   
  
  private

	  def initialize_location_supported_country
      if location_supported_country_params[:location_info_country_id].is_a?(Array)
        @location_supported_countries = []
        location_id = location_supported_country_params[:location_info_location_id]
        location_supported_country_params[:location_info_country_id].reject(&:blank?).each do |supported_country|
          @location_supported_countries << LocationInfo::LocationSupportedCountry.new({location_info_location_id: location_id, location_info_country_id: supported_country})
        end        
      elsif location_supported_country_params[:location_info_location_id].is_a?(Array)
        @location_supported_countries = []
        supported_country_id = location_supported_country_params[:location_info_country_id]
        location_supported_country_params[:location_info_location_id].reject(&:blank?).each do |location|
          @location_supported_countries << LocationInfo::LocationSupportedCountry.new({location_info_location_id: location, location_info_country_id: supported_country_id})
        end
      end	 	    
	  end  #  def initialize_location_supported_country	
  
    def load_location_supported_country
      @location_supported_country = LocationInfo::LocationSupportedCountry.find(params[:id])
    end 	
	
	  def location_supported_country_params
	    params.require(:location_info_location_supported_country).permit!
	  end   
  
end  #  class LocationInfo::Admin::LocationSupportedCountriesController < LocationInfo::AdminController
