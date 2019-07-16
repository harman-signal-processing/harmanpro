class DistributorInfo::Admin::DistributorContactsController < DistributorInfo::AdminController
	before_action :initialize_distributor_contact, only: :create
	before_action :load_distributor_contact, only: [:destroy]   
	
  # GET /distributor_info/admin/distributor_contacts/new
  # GET /distributor_info/admin/distributor_contacts/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @distributor_contact }
    end
  end  
  
  # POST /distributor_info/admin/distributor_contacts
  # POST /distributor_info/admin/distributor_contacts.xml
  def create
    @called_from = params[:called_from] || "distributor"
    respond_to do |format|
      if @distributor_contacts.present?
        begin
          @distributor_contacts.each do |distributor_contact|
            begin
              distributor_contact.save!
              @distributor_contact = distributor_contact
              add_log(user: current_user, action: "Associated #{distributor_contact.distributor.name} with #{distributor_contact.contact.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{distributor_contact.contact.name}"
              format.js { render template: "/distributor_info/admin/distributor_contacts/create_error" }
            end
          end  #  @distributor_contacts.each do |distributor_contact|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/distributor_info/admin/distributor_contacts/create_error" }
        end        
      else       
          @error = "Error no distributor_contacts provided."
          format.html { render action: "new" }
          format.xml  { render xml: @distributor_contact.errors, status: :unprocessable_entity }
          format.js { render template: "/distributor_info/admin/distributor_contacts/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create  
  
  # PUT /distributor_info/admin/distributor_contacts/1
  # PUT /distributor_info/admin/distributor_contacts/1.xml
  def update
    respond_to do |format|
      if @distributor_contact.update_attributes(distributor_contact_params)
        format.html { redirect_to(admin_distributor_contacts_url, notice: 'distributor contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @distributor_contact.errors, status: :unprocessable_entity }
      end
    end
  end	  
  
  def update_order
    update_list_order(DistributorInfo::DistributorContact, params["distributor_contact"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted distributor contacts")
  end     
  
  # DELETE /distributor_info/admin/distributor_contacts/1
  # DELETE /distributor_info/admin/distributor_contacts/1.xml
  def destroy
    @called_from = params[:called_from] || "distributor"
    @distributor_contact.destroy
    respond_to do |format|
      format.html { redirect_to(admin_distributor_contacts_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed a contact from #{@distributor_contact.distributor.name}")
  end   
  
  private

	  def initialize_distributor_contact
      if distributor_contact_params[:contact_info_contact_id].is_a?(Array)
        @distributor_contacts = []
        distributor_id = distributor_contact_params[:distributor_info_distributor_id]
        distributor_contact_params[:contact_info_contact_id].reject(&:blank?).each do |contact|
          @distributor_contacts << DistributorInfo::DistributorContact.new({distributor_info_distributor_id: distributor_id, contact_info_contact_id: contact})
        end        
      elsif distributor_contact_params[:distributor_info_distributor_id].is_a?(Array)
        @distributor_contacts = []
        contact_id = distributor_contact_params[:contact_info_contact_id]
        distributor_contact_params[:distributor_info_distributor_id].reject(&:blank?).each do |distributor|
          @distributor_contacts << DistributorInfo::DistributorContact.new({distributor_info_distributor_id: distributor, contact_info_contact_id: contact_id})
        end
      end	 	    
	  end  #  def initialize_distributor_contact	  
  
    def load_distributor_contact
      @distributor_contact = DistributorInfo::DistributorContact.find(params[:id])
    end 	
	
	  def distributor_contact_params
	    params.require(:distributor_info_distributor_contact).permit!
	  end     
  
end  #  class DistributorInfo::Admin::DistributorContactsController < DistributorInfo::AdminController
