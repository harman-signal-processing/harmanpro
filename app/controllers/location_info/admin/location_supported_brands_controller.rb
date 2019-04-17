class LocationInfo::Admin::LocationSupportedBrandsController < LocationInfo::AdminController
	before_action :initialize_location_supported_brand, only: :create
	before_action :load_location_supported_brand, only: [:destroy]  
	
  # GET /location_info/admin/location_supported_brands/new
  # GET /location_info/admin/location_supported_brands/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @location_supported_brand }
    end
  end
  
  # POST /location_info/admin/location_supported_brands
  # POST /location_info/admin/location_supported_brands.xml
  def create
    @called_from = params[:called_from] || "location"
    respond_to do |format|
      if @location_supported_brands.present?
        begin
          @location_supported_brands.each do |location_supported_brand|
            begin
              location_supported_brand.save!
              @location_supported_brand = location_supported_brand
              # website.add_log(user: current_user, action: "Associated #{location_supported_brand.location.name} with #{location_supported_brand.supported_brand.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{location_supported_brand.brand.name}"
              format.js { render template: "/location_info/admin/location_supported_brands/create_error" }
            end
          end  #  @location_supported_brands.each do |location_supported_brand|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/location_info/admin/location_supported_brands/create_error" }
        end        
      else       
          @error = "No location_supported_brands provided."
          format.html { render action: "new" }
          format.xml  { render xml: @location_supported_brand.errors, status: :unprocessable_entity }
          format.js { render template: "/location_info/admin/location_supported_brands/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create   
  
  # PUT /location_info/admin/location_supported_brands/1
  # PUT /location_info/admin/location_supported_brands/1.xml
  def update
    respond_to do |format|
      if @location_supported_brand.update_attributes(location_supported_brand_params)
        format.html { redirect_to(admin_location_supported_brands_url, notice: 'Location supported_brand was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @location_supported_brand.errors, status: :unprocessable_entity }
      end
    end
  end   
  
  def update_order
    update_list_order(LocationInfo::LocationSupportedBrand, params["location_supported_brand"]) # update_list_order is in application_controller
    head :ok
    # website.add_log(user: current_user, action: "Sorted location supported_brands")
  end    
  
  # DELETE /location_info/admin/location_supported_brands/1
  # DELETE /location_info/admin/location_supported_brands/1.xml
  def destroy
    @called_from = params[:called_from] || "location"
    @location_supported_brand.destroy
    respond_to do |format|
      format.html { redirect_to(admin_location_supported_brands_url) }
      format.xml  { head :ok }
      format.js 
    end
    # website.add_log(user: current_user, action: "Removed a supported_brand from #{@location_supported_brand.location.name}")
  end  
  
  private

	  def initialize_location_supported_brand
      if location_supported_brand_params[:brand_id].is_a?(Array)
        @location_supported_brands = []
        location_id = location_supported_brand_params[:location_info_location_id]
        location_supported_brand_params[:brand_id].reject(&:blank?).each do |supported_brand|
          @location_supported_brands << LocationInfo::LocationSupportedBrand.new({location_info_location_id: location_id, brand_id: supported_brand})
        end        
      elsif location_supported_brand_params[:location_info_location_id].is_a?(Array)
        @location_supported_brands = []
        supported_brand_id = location_supported_brand_params[:brand_id]
        location_supported_brand_params[:location_info_location_id].reject(&:blank?).each do |location|
          @location_supported_brands << LocationInfo::LocationSupportedBrand.new({location_info_location_id: location, brand_id: supported_brand_id})
        end
      end	 	    
	  end  #  def initialize_location_supported_brand  
  
    def load_location_supported_brand
      @location_supported_brand = LocationInfo::LocationSupportedBrand.find(params[:id])
    end 	
	
	  def location_supported_brand_params
	    params.require(:location_info_location_supported_brand).permit!
	  end   
  
end  #  class LocationInfo::Admin::LocationSupportedBrandsController < LocationInfo::AdminController
