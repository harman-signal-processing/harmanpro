class DistributorInfo::Admin::DistributorCountriesController < DistributorInfo::AdminController
	before_action :initialize_distributor_country, only: :create
	before_action :load_distributor_country, only: [:destroy] 
	
  # GET /distributor_info/admin/distributor_countries/new
  # GET /distributor_info/admin/distributor_countries/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @distributor_country }
    end
  end  	
	
  # POST /distributor_info/admin/distributor_countries
  # POST /distributor_info/admin/distributor_countries.xml
  def create
    @called_from = params[:called_from] || "distributor"
    respond_to do |format|
      if @distributor_countries.present?
        begin
          @distributor_countries.each do |distributor_country|
            begin
              distributor_country.save!
              @distributor_country = distributor_country
              # website.add_log(user: current_user, action: "Associated #{distributor_country.distributor.name} with #{distributor_country.country.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{distributor_country.country.name}"
              format.js { render template: "/distributor_info/admin/distributor_countries/create_error" }
            end
          end  #  @distributor_countries.each do |distributor_country|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/distributor_info/admin/distributor_countries/create_error" }
        end        
      else       
          @error = "No distributor_countries provided."
          format.html { render action: "new" }
          format.xml  { render xml: @distributor_country.errors, status: :unprocessable_entity }
          format.js { render template: "/distributor_info/admin/distributor_countries/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create  	
  
  # PUT /distributor_info/admin/distributor_countries/1
  # PUT /distributor_info/admin/distributor_countries/1.xml
  def update
    respond_to do |format|
      if @distributor_country.update_attributes(distributor_country_params)
        format.html { redirect_to(admin_distributor_countries_url, notice: 'distributor country was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @distributor_country.errors, status: :unprocessable_entity }
      end
    end
  end	  
	
  def update_order
    update_list_order(DistributorInfo::DistributorCountry, params["distributor_country"]) # update_list_order is in application_controller
    head :ok
    # website.add_log(user: current_user, action: "Sorted distributor countries")
  end 	
  
  # DELETE /distributor_info/admin/distributor_countries/1
  # DELETE /distributor_info/admin/distributor_countries/1.xml
  def destroy
    @called_from = params[:called_from] || "distributor"
    @distributor_country.destroy
    respond_to do |format|
      format.html { redirect_to(admin_distributor_countries_url) }
      format.xml  { head :ok }
      format.js 
    end
    # website.add_log(user: current_user, action: "Removed a country from #{@distributor_country.distributor.name}")
  end    
	
  private

	  def initialize_distributor_country
      if distributor_country_params[:location_info_country_id].is_a?(Array)
        @distributor_countries = []
        distributor_id = distributor_country_params[:distributor_info_distributor_id]
        distributor_country_params[:location_info_country_id].reject(&:blank?).each do |country|
          @distributor_countries << DistributorInfo::DistributorCountry.new({distributor_info_distributor_id: distributor_id, location_info_country_id: country})
        end        
      elsif distributor_country_params[:distributor_info_distributor_id].is_a?(Array)
        @distributor_countries = []
        country_id = distributor_country_params[:location_info_country_id]
        distributor_country_params[:distributor_info_distributor_id].reject(&:blank?).each do |distributor|
          @distributor_countries << DistributorInfo::DistributorCountry.new({distributor_info_distributor_id: distributor, location_info_country_id: country_id})
        end
      end	 	    
	  end  #  def initialize_distributor_country	
	
    def load_distributor_country
      @distributor_country = DistributorInfo::DistributorCountry.find(params[:id])
    end 	
	
	  def distributor_country_params
	    params.require(:distributor_info_distributor_country).permit!
	  end  	
	
end  #  class DistributorInfo::Admin::DistributorCountriesController < DistributorInfo::AdminController
