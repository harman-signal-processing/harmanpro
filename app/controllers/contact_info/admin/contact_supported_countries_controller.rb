class ContactInfo::Admin::ContactSupportedCountriesController < ContactInfo::AdminController
	before_action :initialize_contact_supported_country, only: :create
	before_action :load_contact_supported_country, only: [:destroy]  
	
  # GET /contact_info/admin/contact_supported_countries/new
  # GET /contact_info/admin/contact_supported_countries/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @contact_supported_country }
    end
  end	
	
  # POST /contact_info/admin/contact_supported_countries
  # POST /contact_info/admin/contact_supported_countries.xml
  def create
    @called_from = params[:called_from] || "contact"
    respond_to do |format|
      if @contact_supported_countries.present?
        begin
          @contact_supported_countries.each do |contact_supported_country|
            begin
              contact_supported_country.save!
              @contact_supported_country = contact_supported_country
              add_log(user: current_user, action: "Associated #{contact_supported_country.contact.name} with #{contact_supported_country.country.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{contact_supported_country.country.name}"
              format.js { render template: "/contact_info/admin/contact_supported_countries/create_error" }
            end
          end  #  @contact_supported_countries.each do |contact_supported_country|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/contact_info/admin/contact_supported_countries/create_error" }
        end        
      else       
          @error = "No contact_supported_countries provided."
          format.html { render action: "new" }
          format.xml  { render xml: @contact_supported_country.errors, status: :unprocessable_entity }
          format.js { render template: "/contact_info/admin/contact_supported_countries/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create 	
	
  # PUT /contact_info/admin/contact_supported_countries/1
  # PUT /contact_info/admin/contact_supported_countries/1.xml
  def update
    respond_to do |format|
      if @contact_supported_country.update_attributes(contact_supported_country_params)
        format.html { redirect_to(admin_contact_supported_countries_url, notice: 'Contact supported_country was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @contact_supported_country.errors, status: :unprocessable_entity }
      end
    end
  end 	
	
  def update_order
    update_list_order(ContactInfo::ContactSupportedCountry, params["contact_supported_country"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted contact supported_countries")
  end  	
  
  # DELETE /contact_info/admin/contact_supported_countries/1
  # DELETE /contact_info/admin/contact_supported_countries/1.xml
  def destroy
    @called_from = params[:called_from] || "contact"
    @contact_supported_country.destroy
    respond_to do |format|
      format.html { redirect_to(admin_contact_supported_countries_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed #{@contact_supported_country.country.name} from #{@contact_supported_country.contact.name}")
  end   
	
  private

	  def initialize_contact_supported_country
      if contact_supported_country_params[:location_info_country_id].is_a?(Array)
        @contact_supported_countries = []
        contact_id = contact_supported_country_params[:contact_info_contact_id]
        contact_supported_country_params[:location_info_country_id].reject(&:blank?).each do |supported_country|
          @contact_supported_countries << ContactInfo::ContactSupportedCountry.new({contact_info_contact_id: contact_id, location_info_country_id: supported_country})
        end        
      elsif contact_supported_country_params[:contact_info_contact_id].is_a?(Array)
        @contact_supported_countries = []
        supported_country_id = contact_supported_country_params[:location_info_country_id]
        contact_supported_country_params[:contact_info_contact_id].reject(&:blank?).each do |contact|
          @contact_supported_countries << ContactInfo::ContactSupportedCountry.new({contact_info_contact_id: contact, location_info_country_id: supported_country_id})
        end
      end	 	    
	  end  #  def initialize_contact_supported_country 	
	
    def load_contact_supported_country
      @contact_supported_country = ContactInfo::ContactSupportedCountry.find(params[:id])
    end 	
	
	  def contact_supported_country_params
	    params.require(:contact_info_contact_supported_country).permit!
	  end 	
	
end  #  class ContactInfo::Admin::ContactSupportedCountriesController < ContactInfo::AdminController
