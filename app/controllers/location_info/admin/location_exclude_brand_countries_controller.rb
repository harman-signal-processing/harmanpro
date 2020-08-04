class LocationInfo::Admin::LocationExcludeBrandCountriesController < ApplicationController
  before_action :initialize_location_exclude_brand_country, only: :create
	before_action :load_location_exclude_brand_country, only: [:destroy] 
	
  # GET /location_info/admin/location_exclude_brand_countries/new
  # GET /location_info/admin/location_exclude_brand_countries/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @location_exclude_brand_country }
    end
  end  	
  
  # POST /location_info/admin/location_exclude_brand_countries
  # POST /location_info/admin/location_exclude_brand_countries.xml
  def create
    @called_from = params[:called_from] || "location"
    respond_to do |format|
      if @excluded_brands_countries.present?
        begin
          @excluded_brands_countries.each do |excluded_brand_country|
            begin
              excluded_brand_country.save!
              @excluded_brand_country = excluded_brand_country
              add_log(user: current_user, action: "Exclude #{location_exclude_brand_country.location.name} from #{location_exclude_brand_country.brand.name} / #{location_exclude_brand_country.country.harman_name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{excluded_brand_country.location.name} #{excluded_brand_country.brand.name}  #{excluded_brand_country.country.harman_name}"
              format.js { render template: "/location_info/admin/location_exclude_brand_countries/create_error" }
            end
          end  #  @excluded_brands_countries.each do |location_country|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/location_info/admin/location_exclude_brand_countries/create_error" }
        end        
      else       
          @error = "No location_exclude_brand_countries provided."
          format.html { render action: "new" }
          format.xml  { render xml: @excluded_brands_countries.errors, status: :unprocessable_entity }
          format.js { render template: "/location_info/admin/location_exclude_brand_countries/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create   
	
  # PUT /location_info/admin/location_exclude_brand_countries/1
  # PUT /location_info/admin/location_exclude_brand_countries/1.xml
  def update
    respond_to do |format|
      if @excluded_brands_countries.update(location_exclude_brand_country_params)
        format.html { redirect_to(admin_location_exclude_brand_countries_url, notice: 'location brand/country exclusion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @excluded_brands_countries.errors, status: :unprocessable_entity }
      end
    end
  end	 		
	
  # DELETE /location_info/admin/location_exclude_brand_countries/1
  # DELETE /location_info/admin/location_exclude_brand_countries/1.xml
  def destroy
    @called_from = params[:called_from] || "location"
    @excluded_brand_country.destroy
    respond_to do |format|
      format.html { redirect_to(admin_location_exclude_brand_countries_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed an #{@excluded_brand_country.brand.name}/#{@excluded_brand_country.country.harman_name} exclusion from #{@excluded_brand_country.location.name}")
  end 		
  
  private
  
	def initialize_location_exclude_brand_country
		@excluded_brands_countries = []
		location_id = location_exclude_brand_country_params[:location_info_location_id]
		
        location_exclude_brand_country_params[:brand_country].reject(&:blank?).each do |bc|
        	brand_country_ids = bc.split('_')
        	brand_id = brand_country_ids[0]
        	country_id = brand_country_ids[1]
          @excluded_brands_countries << LocationInfo::LocationExcludeBrandCountry.new({location_info_location_id: location_id, location_info_country_id: country_id, brand_id: brand_id})
        end 		
		
	end  #  initialize_location_exclude_brand_country  
	
	def load_location_exclude_brand_country
		@excluded_brand_country = LocationInfo::LocationExcludeBrandCountry.find(params[:id])	  
	end  #  load_location_exclude_brand_country
	
	def location_exclude_brand_country_params
	    params.require(:location_info_location_exclude_brand_country).permit!
	end 	
	
end  #  class LocationInfo::Admin::LocationExcludeBrandCountriesController < ApplicationController
