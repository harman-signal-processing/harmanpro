class DistributorInfo::Admin::DistributorExcludeBrandCountriesController < ApplicationController
	before_action :initialize_distributor_exclude_brand_country, only: :create
	before_action :load_distributor_exclude_brand_country, only: [:destroy]   
	
  # GET /distributor_info/admin/distributor_exclude_brand_countries/new
  # GET /distributor_info/admin/distributor_exclude_brand_countries/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @distributor_exclude_brand_country }
    end
  end  	
  
  # POST /distributor_info/admin/distributor_exclude_brand_countries
  # POST /distributor_info/admin/distributor_exclude_brand_countries.xml
  def create
    @called_from = params[:called_from] || "distributor"
    respond_to do |format|
      if @excluded_brands_countries.present?
        begin
          @excluded_brands_countries.each do |excluded_brand_country|
            begin
              excluded_brand_country.save!
              @excluded_brand_country = excluded_brand_country
              add_log(user: current_user, action: "Exclude #{distributor_exclude_brand_country.distributor.name} from #{distributor_exclude_brand_country.brand.name} / #{distributor_exclude_brand_country.country.harman_name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{excluded_brand_country.distributor.name} #{excluded_brand_country.brand.name}  #{excluded_brand_country.country.harman_name}"
              format.js { render template: "/distributor_info/admin/distributor_exclude_brand_countries/create_error" }
            end
          end  #  @excluded_brands_countries.each do |distributor_country|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/distributor_info/admin/distributor_exclude_brand_countries/create_error" }
        end        
      else       
          @error = "No distributor_exclude_brand_countries provided."
          format.html { render action: "new" }
          format.xml  { render xml: @excluded_brands_countries.errors, status: :unprocessable_entity }
          format.js { render template: "/distributor_info/admin/distributor_exclude_brand_countries/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create   
	
  # PUT /distributor_info/admin/distributor_exclude_brand_countries/1
  # PUT /distributor_info/admin/distributor_exclude_brand_countries/1.xml
  def update
    respond_to do |format|
      if @excluded_brands_countries.update_attributes(distributor_exclude_brand_country_params)
        format.html { redirect_to(admin_distributor_exclude_brand_countries_url, notice: 'distributor brand/country exclusion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @excluded_brands_countries.errors, status: :unprocessable_entity }
      end
    end
  end	 	
	
  # DELETE /distributor_info/admin/distributor_exclude_brand_countries/1
  # DELETE /distributor_info/admin/distributor_exclude_brand_countries/1.xml
  def destroy
    @called_from = params[:called_from] || "distributor"
    @excluded_brand_country.destroy
    respond_to do |format|
      format.html { redirect_to(admin_distributor_exclude_brand_countries_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed #{@excluded_brand_country.brand.name}/#{@excluded_brand_country.country.harman_name} exclusion from #{@excluded_brand_country.distributor.name}")
  end 	
	
	private
	
	def initialize_distributor_exclude_brand_country
		@excluded_brands_countries = []
		distributor_id = distributor_exclude_brand_country_params[:distributor_info_distributor_id]
		
        distributor_exclude_brand_country_params[:brand_country].reject(&:blank?).each do |bc|
        	brand_country_ids = bc.split('_')
        	brand_id = brand_country_ids[0]
        	country_id = brand_country_ids[1]
          @excluded_brands_countries << DistributorInfo::DistributorExcludeBrandCountry.new({distributor_info_distributor_id: distributor_id, location_info_country_id: country_id, brand_id: brand_id})
        end 		
		
	end  #  initialize_distributor_exclude_brand_country
	
	def load_distributor_exclude_brand_country
		@excluded_brand_country = DistributorInfo::DistributorExcludeBrandCountry.find(params[:id])	  
	end  #  load_distributor_exclude_brand_country
	
	def distributor_exclude_brand_country_params
	    params.require(:distributor_info_distributor_exclude_brand_country).permit!
	end 
	
end  #  class DistributorInfo::Admin::DistributorExcludeBrandCountriesController < ApplicationController
