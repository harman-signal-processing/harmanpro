class ContactInfo::Admin::TerritoriesController < ContactInfo::AdminController
  before_action :load_territory, only: [:edit, :update, :destroy]
  
  def index
    @territories = ContactInfo::Territory.all.order(:name)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @territories }
      format.json  { render json: @territories }
    end    
  end
  
  def new
    contact_id = params[:territory][:contact_id] unless params[:territory].nil?
    @contact = ContactInfo::Contact.find(contact_id) if contact_id.present?
    @territory = ContactInfo::Territory.new
  end
  
  def edit
    @contact_territory = ContactInfo::ContactTerritory.new(contact_info_territory_id: @territory.id)
    @contact_territories = ContactInfo::ContactTerritory.where(contact_info_territory_id: @territory.id)
    
    @territory_supported_country = ContactInfo::TerritorySupportedCountry.new(contact_info_territory_id: @territory.id)
    @territory_supported_countries = ContactInfo::TerritorySupportedCountry.where(contact_info_territory_id: @territory.id)
  end
  
  def update
    respond_to do |format|
      if @territory.update_attributes({territory: territory_params[:territory], label: territory_params[:label]})
        format.html { redirect_to(contact_info_admin_territories_path, notice: "Territory #{@territory.name} was successfully updated.") }
        format.xml  { head :ok }
        add_log(user: current_user, action: "Updated territory: #{@territory.name}")
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @territory.errors, status: :unprocessable_entity }
      end
    end 
  end
  
  def create
    @territory = ContactInfo::Territory.new({name: territory_params[:name]})
    @contact = territory_params[:contact_id].present? ? ContactInfo::Contact.find(territory_params[:contact_id]) : nil
    respond_to do |format|
      if @territory.save

        @territory.contacts << @contact unless @contact.nil?

        format.html { redirect_to(contact_info_admin_territories_path, notice: "Territory #{@territory.name} was successfully created.") }
        format.xml  { render xml: @territory, status: :created, location: @territory }
        format.js # Not really applicable because the attachment can't be sent via AJAX
        add_log(user: current_user, action: "Created territory #{@territory.name}")
      else
        format.html { redirect_to(contact_info_admin_territories_path, notice: "There was a problem creating the Territory #{@territory.name}.") }
        format.xml  { render xml: @territory.errors, status: :unprocessable_entity }
        format.js { render plain: "Error" }
      end
    end      
  end
  
  # DELETE /contact_info/admin/territories/1
  # DELETE /contact_info/admin/territories/1.xml
  def destroy
    @territory.destroy
    respond_to do |format|
      format.html { redirect_to(contact_info_admin_territories_url) }
      format.xml  { head :ok }
    end
    add_log(user: current_user, action: "Deleted territory: #{@territory.name}")
  end
  
  private
  
    def load_territory
      @territory = ContactInfo::Territory.find(params[:id])
    end   
  
    def territory_params
  	  params.require(:contact_info_territory).permit(:name, :contact_id)
    end   
end  #  class ContactInfo::Admin::TerritoriesController < ContactInfo::AdminController
