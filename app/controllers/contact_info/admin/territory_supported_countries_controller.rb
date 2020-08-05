class ContactInfo::Admin::TerritorySupportedCountriesController < ApplicationController
  before_action :initialize_territory_supported_country, only: :create
  before_action :load_territory_supported_country, only: [:destroy]    
	
  # GET /contact_info/admin/territory_supported_countries/new
  # GET /contact_info/admin/territory_supported_countries/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @territory_supported_country }
    end
  end	
  
  # POST /contact_info/admin/territory_supported_countries
  # POST /contact_info/admin/territory_supported_countries.xml
  def create
    @called_from = params[:called_from] || "contact"
    respond_to do |format|
      if @territory_supported_countries.present?
        begin
          @territory_supported_countries.each do |territory_supported_country|
            begin
              territory_supported_country.save!
              @territory_supported_country = territory_supported_country
              add_log(user: current_user, action: "Associated territory #{territory_supported_country.territory.name} with #{territory_supported_country.country.harman_name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{territory_supported_country.country.harman_name}"
              format.js { render template: "/contact_info/admin/territory_supported_countries/create_error" }
            end
          end  #  @territory_supported_countries.each do |territory_supported_country|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/contact_info/admin/territory_supported_countries/create_error" }
        end        
      else       
          @error = "No territory_supported_countries provided."
          format.html { render action: "new" }
          format.xml  { render xml: @territory_supported_country.errors, status: :unprocessable_entity }
          format.js { render template: "/contact_info/admin/territory_supported_countries/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create   
  
  # PUT /contact_info/admin/territory_supported_countries/1
  # PUT /contact_info/admin/territory_supported_countries/1.xml
  def update
    respond_to do |format|
      if @territory_supported_country.update(territory_supported_country_params)
        format.html { redirect_to(admin_territory_supported_countries_url, notice: 'Territory supported_country was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @territory_supported_country.errors, status: :unprocessable_entity }
      end
    end
  end   
  
  # DELETE /contact_info/admin/territory_supported_countries/1
  # DELETE /contact_info/admin/territory_supported_countries/1.xml
  def destroy
    @called_from = params[:called_from] || "contact"
    @territory_supported_country.destroy
    respond_to do |format|
      format.html { redirect_to(admin_territory_supported_countries_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed country #{@territory_supported_country.country.harman_name} from territory #{@territory_supported_country.territory.name}")
  end  
  
  private

	  def initialize_territory_supported_country
          if territory_supported_country_params[:location_info_country_id].is_a?(Array) # coming from territories page
            @territory_supported_countries = []
            territory_id = territory_supported_country_params[:contact_info_territory_id]
            territory_supported_country_params[:location_info_country_id].reject(&:blank?).each do |supported_country|
              @territory_supported_countries << ContactInfo::TerritorySupportedCountry.new({contact_info_territory_id: territory_id, location_info_country_id: supported_country})
            end  #  territory_supported_country_params[:location_info_country_id].reject(&:blank?).each do |supported_country|   
          elsif territory_supported_country_params[:contact_info_territory_id].is_a?(Array) # coming from country page
            @territory_supported_countries = []
            supported_country_id = territory_supported_country_params[:location_info_country_id]
            territory_supported_country_params[:contact_info_territory_id].reject(&:blank?).each do |territory|
              @territory_supported_countries << ContactInfo::TerritorySupportedCountry.new({contact_info_territory_id: territory, location_info_country_id: supported_country_id})
            end  #  territory_supported_country_params[:contact_info_territory_id].reject(&:blank?).each do |territory|
          end  #  elsif territory_supported_country_params[:contact_info_territory_id].is_a?(Array)	    
	  end  #  def initialize_territory_supported_country 	
	
    def load_territory_supported_country
      @territory_supported_country = ContactInfo::TerritorySupportedCountry.find(params[:id])
    end 	
	
	  def territory_supported_country_params
	    params.require(:contact_info_territory_supported_country).permit!
	  end   
  
end  #  class ContactInfo::Admin::TerritorySupportedCountriesController < ApplicationController
