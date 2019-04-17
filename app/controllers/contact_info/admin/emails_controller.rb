class ContactInfo::Admin::EmailsController < ContactInfo::AdminController
  before_action :load_email, only: [:edit, :update, :destroy]
  
  def index
    @emails = ContactInfo::Email.all.order(:email)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @emails }
      format.json  { render json: @emails }
    end    
  end

  def new
    contact_id = params[:email][:contact_id] unless params[:email].nil?
    @contact = ContactInfo::Contact.find(contact_id) if contact_id.present?
    
    distributor_id = params[:email][:distributor_id] unless params[:email].nil?
    @distributor = DistributorInfo::Distributor.find(distributor_id) if distributor_id.present?    
    
    location_id = params[:email][:location_id] unless params[:email].nil?
    @location = LocationInfo::Location.find(location_id) if location_id.present?    
    
    @email = ContactInfo::Email.new
  end

  def edit
    @contact_email = ContactInfo::ContactEmail.new(contact_info_email_id: @email.id)
    @contact_emails = ContactInfo::ContactEmail.where(contact_info_email_id: @email.id)   
    
    @distributor_email = DistributorInfo::DistributorEmail.new(contact_info_email_id: @email.id)
    @distributor_emails = DistributorInfo::DistributorEmail.where(contact_info_email_id: @email.id)    
    
    @location_email = LocationInfo::LocationEmail.new(contact_info_email_id: @email.id)
    @location_emails = LocationInfo::LocationEmail.where(contact_info_email_id: @email.id)    
  end

  def update
    respond_to do |format|
      if @email.update_attributes({email: email_params[:email], label: email_params[:label]})
        format.html { redirect_to(contact_info_admin_emails_path, notice: "Email #{@email.email} was successfully updated.") }
        format.xml  { head :ok }
        # website.add_log(user: current_user, action: "Updated email: #{@email.email}")
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @email.errors, status: :unprocessable_entity }
      end
    end 
  end

  def create
    @email = ContactInfo::Email.new({email: email_params[:email], label: email_params[:label]})
    @contact = email_params[:contact_id].present? ? ContactInfo::Contact.find(email_params[:contact_id]) : nil
    @distributor = email_params[:distributor_id].present? ? DistributorInfo::Distributor.find(email_params[:distributor_id]) : nil
    @location = email_params[:location_id].present? ? LocationInfo::Location.find(email_params[:location_id]) : nil
    respond_to do |format|
      if @email.save

        if @contact.present?
          @email.contacts << @contact
          format.html { redirect_to(edit_contact_info_admin_contact_path(@contact), notice: "Email #{@email.email} was successfully created and associated to #{@contact.name}.") }
        elsif @distributor.present?
          @email.distributors << @distributor
          format.html { redirect_to(edit_distributor_info_admin_distributor_path(@distributor), notice: "Email #{@email.email} was successfully created and associated to #{@distributor.name}.") }
        elsif @location.present?
          @email.locations << @location
          format.html { redirect_to(edit_location_info_admin_location_path(@location), notice: "Email #{@email.email} was successfully created and associated to #{@location.name}.") }                    
        else
          format.html { redirect_to(contact_info_admin_emails_path, notice: "Email #{@email.email} was successfully created.") }          
        end
        
        format.xml  { render xml: @email, status: :created, location: @email }
        format.js # Not really applicable because the attachment can't be sent via AJAX
        # website.add_log(user: current_user, action: "Created email #{@email.email}")
      else
        format.html { redirect_to(contact_info_admin_emails_path, notice: "There was a problem creating the email #{@email.email}.") }
        format.xml  { render xml: @email.errors, status: :unprocessable_entity }
        format.js { render plain: "Error" }
      end
    end      
  end

  # DELETE /contact_info/admin/emails/1
  # DELETE /contact_info/admin/emails/1.xml
  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to(contact_info_admin_emails_url) }
      format.xml  { head :ok }
    end
    # website.add_log(user: current_user, action: "Deleted contact email: #{@email.email}")
  end
  
  private
  
    def load_email
      @email = ContactInfo::Email.find(params[:id])
      #authorize @contact
    end   
  
    def email_params
  	  params.require(:contact_info_email).permit(:email, :label, :contact_id, :distributor_id, :location_id)
    end   
end  #  class ContactInfo::Admin::EmailsController < ContactInfo::AdminController
