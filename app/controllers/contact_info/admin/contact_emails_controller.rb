class ContactInfo::Admin::ContactEmailsController < ContactInfo::AdminController
	before_action :initialize_contact_email, only: :create
	before_action :load_contact_email, only: [:destroy]
  # load_and_authorize_resource class: "ContactInfo::Email", except: [:update_order]
  # skip_authorization_check only: [:update_order]  
  
  # GET /contact_info/admin/contact_emails/new
  # GET /contact_info/admin/contact_emails/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @contact_email }
    end
  end  

  # POST /contact_info/admin/contact_emails
  # POST /contact_info/admin/contact_emails.xml
  def create
    @called_from = params[:called_from] || "contact"
    respond_to do |format|
      if @contact_emails.present?
        begin
          @contact_emails.each do |contact_email|
            begin
              contact_email.save!
              @contact_email = contact_email
              add_log(user: current_user, action: "Associated #{contact_email.contact.name} with #{contact_email.email.email}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{contact_email.email.email}"
              format.js { render template: "contact_info/admin/contact_emails/create_error" }
            end
          end  #  @contact_emails.each do |contact_email|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "contact_info/admin/contact_emails/create_error" }
        end        
      else       
          @error = "No emails provided."
          format.html { render action: "new" }
          format.xml  { render xml: @contact_email.errors, status: :unprocessable_entity }
          format.js { render template: "contact_info/admin/contact_emails/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create   
  
  # PUT /contact_info/admin/contact_emails/1
  # PUT /contact_info/admin/contact_emails/1.xml
  def update
    respond_to do |format|
      if @contact_email.update_attributes(contact_email_params)
        format.html { redirect_to(contact_info_admin_contact_emails_path, notice: 'Contact email was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @contact_email.errors, status: :unprocessable_entity }
      end
    end
  end   
  
  def update_order
    update_list_order(ContactInfo::ContactEmail, params["contact_info_contact_email"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted Contact emails")
  end  
  
  # DELETE /contact_info/admin/contact_emails/1
  # DELETE /contact_info/admin/contact_emails/1.xml
  def destroy
    @called_from = params[:called_from] || "contact"
    @contact_email.destroy
    respond_to do |format|
      format.html { redirect_to(contact_info_admin_contact_emails_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed an email from #{@contact_email.contact.name}")
  end 
  
  private

	  def initialize_contact_email
      if contact_email_params[:contact_info_email_id].is_a?(Array)
        @contact_emails = []
        contact_id = contact_email_params[:contact_info_contact_id]
        contact_email_params[:contact_info_email_id].reject(&:blank?).each do |email|
          @contact_emails << ContactInfo::ContactEmail.new({contact_info_contact_id: contact_id, contact_info_email_id: email})
        end        
      elsif contact_email_params[:contact_info_contact_id].is_a?(Array)
        @contact_emails = []
        email_id = contact_email_params[:contact_info_email_id]
        contact_email_params[:contact_info_contact_id].reject(&:blank?).each do |contact|
          @contact_emails << ContactInfo::ContactEmail.new({contact_info_contact_id: contact, contact_info_email_id: email_id})
        end
      end	 	    
	  end  #  def initialize_contact_email
	
	  def load_contact_email
      @contact_email = ContactInfo::ContactEmail.find(params[:id])
    end 
	
	  def contact_email_params
	    params.require(:contact_info_contact_email).permit!
	  end   
end  #  class ContactInfo::Admin::ContactEmailsController < ContactInfo::AdminController
