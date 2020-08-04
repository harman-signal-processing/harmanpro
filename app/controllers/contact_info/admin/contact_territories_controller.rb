class ContactInfo::Admin::ContactTerritoriesController < ContactInfo::AdminController
	before_action :initialize_contact_territory, only: :create
	before_action :load_contact_territory, only: [:destroy]
	
  # GET /contact_info/admin/contact_territories/new
  # GET /contact_info/admin/contact_territories/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @contact_territory }
    end
  end
  
  # POST /contact_info/admin/contact_territories
  # POST /contact_info/admin/contact_territories.xml
  def create
    @called_from = params[:called_from] || "contact"
    respond_to do |format|
      if @contact_territories.present?
        begin
          @contact_territories.each do |contact_territory|
            begin
              contact_territory.save!
              @contact_territory = contact_territory
              add_log(user: current_user, action: "Associated #{contact_territory.contact.name} with #{contact_territory.territory.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{contact_territory.territory.name}"
              format.js { render template: "/contact_info/admin/contact_territories/create_error" }
            end
          end  #  @contact_territories.each do |contact_territory|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/contact_info/admin/contact_territories/create_error" }
        end        
      else       
          @error = "No territories provided."
          format.html { render action: "new" }
          format.xml  { render xml: @contact_territory.errors, status: :unprocessable_entity }
          format.js { render template: "/contact_info/admin/contact_territories/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create
  
  # PUT /contact_info/admin/contact_territories/1
  # PUT /contact_info/admin/contact_territories/1.xml
  def update
    respond_to do |format|
      if @contact_territory.update(contact_territory_params)
        format.html { redirect_to(admin_contact_territories_url, notice: 'Contact territory was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @contact_territory.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_order
    update_list_order(ContactInfo::ContactTerritory, params["contact_territory"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted contact territories")
  end 
  
  # DELETE /contact_info/admin/contact_territories/1
  # DELETE /contact_info/admin/contact_territories/1.xml
  def destroy
    @called_from = params[:called_from] || "contact"
    @contact_territory.destroy
    respond_to do |format|
      format.html { redirect_to(admin_contact_territories_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed territory #{@contact_territory.territory.name} from #{@contact_territory.contact.name}")
  end 
  
  private

	  def initialize_contact_territory
      if contact_territory_params[:contact_info_territory_id].is_a?(Array)
        @contact_territories = []
        contact_id = contact_territory_params[:contact_info_contact_id]
        contact_territory_params[:contact_info_territory_id].reject(&:blank?).each do |territory|
          @contact_territories << ContactInfo::ContactTerritory.new({contact_info_contact_id: contact_id, contact_info_territory_id: territory})
        end        
      elsif contact_territory_params[:contact_info_contact_id].is_a?(Array)
        @contact_territories = []
        territory_id = contact_territory_params[:contact_info_territory_id]
        contact_territory_params[:contact_info_contact_id].reject(&:blank?).each do |contact|
          @contact_territories << ContactInfo::ContactTerritory.new({contact_info_contact_id: contact, contact_info_territory_id: territory_id})
        end
      end	 	    
	  end  #  def initialize_contact_territory
	  
    def load_contact_territory
      @contact_territory = ContactInfo::ContactTerritory.find(params[:id])
    end 	
	
	  def contact_territory_params
	    params.require(:contact_info_contact_territory).permit!
	  end 	  
end  #  class ContactInfo::Admin::ContactTerritoriesController < ContactInfo::AdminController
