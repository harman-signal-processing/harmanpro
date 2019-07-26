class ContactInfo::Admin::ContactDataClientsController < ContactInfo::AdminController
  before_action :initialize_contact_data_client, only: :create
	before_action :load_contact_data_client, only: :destroy
	
  # GET /contact_info/admin/contact_data_clients/new
  # GET /contact_info/admin/contact_data_clients/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @contact_data_client }
    end
  end	
	
  # POST /contact_info/admin/contact_data_clients
  # POST /contact_info/admin/contact_data_clients.xml
  def create
    @called_from = params[:called_from] || "contact"
    respond_to do |format|
      if @contact_data_clients.present?
        begin
          @contact_data_clients.each do |contact_data_client|
            begin
              contact_data_client.save!
              @contact_data_client = contact_data_client
              add_log(user: current_user, action: "Associated #{contact_data_client.contact.name} with #{contact_data_client.data_client.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{contact_data_client.data_client.name}"
              format.js { render template: "/contact_info/admin/contact_data_clients/create_error" }
            end
          end  #  @contact_data_clients.each do |contact_data_client|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/contact_info/admin/contact_data_clients/create_error" }
        end        
      else       
          @error = "No data_clients provided."
          format.html { render action: "new" }
          format.xml  { render xml: @contact_data_client.errors, status: :unprocessable_entity }
          format.js { render template: "/contact_info/admin/contact_data_clients/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create
  
  # PUT /contact_info/admin/contact_data_clients/1
  # PUT /contact_info/admin/contact_data_clients/1.xml
  def update
    respond_to do |format|
      if @contact_data_client.update_attributes(contact_data_client_params)
        format.html { redirect_to(admin_contact_data_clients_url, notice: 'Contact data_client was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @contact_data_client.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_order
    update_list_order(ContactInfo::ContactDataClient, params["contact_data_client"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted contact data_clients")
  end 

  # DELETE /contact_info/admin/contact_data_clients/1
  # DELETE /contact_info/admin/contact_data_clients/1.xml
  def destroy
    @called_from = params[:called_from] || "contact"
    @contact_data_client.destroy
    respond_to do |format|
      format.html { redirect_to(admin_contact_data_clients_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed #{@contact_data_client.data_client.name} from #{@contact_data_client.contact.name}")
  end 
  
  private

	  def initialize_contact_data_client
      if contact_data_client_params[:contact_info_data_client_id].is_a?(Array)
        @contact_data_clients = []
        contact_id = contact_data_client_params[:contact_info_contact_id]
        contact_data_client_params[:contact_info_data_client_id].reject(&:blank?).each do |data_client|
          @contact_data_clients << ContactInfo::ContactDataClient.new({contact_info_contact_id: contact_id, contact_info_data_client_id: data_client})
        end        
      elsif contact_data_client_params[:contact_info_contact_id].is_a?(Array)
        @contact_data_clients = []
        data_client_id = contact_data_client_params[:contact_info_data_client_id]
        contact_data_client_params[:contact_info_contact_id].reject(&:blank?).each do |contact|
          @contact_data_clients << ContactInfo::ContactDataClient.new({contact_info_contact_id: contact, contact_info_data_client_id: data_client_id})
        end
      end	 	    
	  end  #  def initialize_contact_data_client
	
    def load_contact_data_client
      @contact_data_client = ContactInfo::ContactDataClient.find(params[:id])
    end 	
	
	  def contact_data_client_params
	    params.require(:contact_info_contact_data_client).permit!
	  end
	  
end  #  class ContactInfo::Admin::ContactDataClientsController < ContactInfo::AdminController
