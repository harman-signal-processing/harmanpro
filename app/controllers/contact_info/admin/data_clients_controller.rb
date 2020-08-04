class ContactInfo::Admin::DataClientsController < ContactInfo::AdminController
  before_action :load_data_client, only: [:edit, :update, :destroy]
  
  def index
    @data_clients = ContactInfo::DataClient.all.order(:name)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @data_clients }
      format.json  { render json: @data_clients }
    end    
  end
  
  def new
    contact_id = params[:data_client][:contact_id] unless params[:data_client].nil?
    @contact = ContactInfo::Contact.find(contact_id) if contact_id.present?
    @data_client = ContactInfo::DataClient.new
  end
  
  def edit
    @contact_data_client = ContactInfo::ContactDataClient.new(contact_info_data_client_id: @data_client.id)
    @contact_data_clients = ContactInfo::ContactDataClient.where(contact_info_data_client_id: @data_client.id)
  end
  
  
  def update
    respond_to do |format|
      if @data_client.update({name: data_client_params[:name]})
        format.html { redirect_to(contact_info_admin_data_clients_path, notice: "DataClient #{@data_client.name} was successfully updated.") }
        format.xml  { head :ok }
        add_log(user: current_user, action: "Updated data_client: #{@data_client.name}")
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @data_client.errors, status: :unprocessable_entity }
      end
    end 
  end
  
  def create
    @data_client = ContactInfo::DataClient.new({name: data_client_params[:name]})
    @contact = data_client_params[:contact_id].present? ? ContactInfo::Contact.find(data_client_params[:contact_id]) : nil
    respond_to do |format|
      if @data_client.save

        @data_client.contacts << @contact unless @contact.nil?

        format.html { redirect_to(contact_info_admin_data_clients_path, notice: "DataClient #{@data_client.name} was successfully created.") }
        format.xml  { render xml: @data_client, status: :created, location: @data_client }
        format.js # Not really applicable because the attachment can't be sent via AJAX
        add_log(user: current_user, action: "Created data_client #{@data_client.name}")
      else
        format.html { redirect_to(contact_info_admin_data_clients_path, notice: "There was a problem creating the DataClient #{@data_client.name}.") }
        format.xml  { render xml: @data_client.errors, status: :unprocessable_entity }
        format.js { render plain: "Error" }
      end
    end      
  end
  
  # DELETE /contact_info/admin/data_clients/1
  # DELETE /contact_info/admin/data_clients/1.xml
  def destroy
    @data_client.destroy
    respond_to do |format|
      format.html { redirect_to(contact_info_admin_data_clients_url) }
      format.xml  { head :ok }
    end
    add_log(user: current_user, action: "Deleted data_client: #{@data_client.name}")
  end
  
  private
  
    def load_data_client
      @data_client = ContactInfo::DataClient.find(params[:id])
    end   
  
    def data_client_params
  	  params.require(:contact_info_data_client).permit(:name, :contact_id)
    end  
    
      
end  #  class ContactInfo::Admin::DataClientsController < ContactInfo::AdminController
