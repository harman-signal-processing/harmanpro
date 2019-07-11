class DistributorInfo::Admin::DistributorEmailsController < DistributorInfo::AdminController
	before_action :initialize_distributor_email, only: :create
	before_action :load_distributor_email, only: [:destroy]   
	
  # GET /distributor_info/admin/distributor_emails/new
  # GET /distributor_info/admin/distributor_emails/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @distributor_email }
    end
  end	
  
  # POST /distributor_info/admin/distributor_emails
  # POST /distributor_info/admin/distributor_emails.xml
  def create
    @called_from = params[:called_from] || "distributor"
    respond_to do |format|
      if @distributor_emails.present?
        begin
          @distributor_emails.each do |distributor_email|
            begin
              distributor_email.save!
              @distributor_email = distributor_email
              add_log(user: current_user, action: "Associated #{distributor_email.distributor.name} with #{distributor_email.email.email}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{distributor_email.email.email}"
              format.js { render template: "/distributor_info/admin/distributor_emails/create_error" }
            end
          end  #  @distributor_emails.each do |distributor_email|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/distributor_info/admin/distributor_emails/create_error" }
        end        
      else       
          @error = "Error no distributor_emails provided."
          format.html { render action: "new" }
          format.xml  { render xml: @distributor_email.errors, status: :unprocessable_entity }
          format.js { render template: "/distributor_info/admin/distributor_emails/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create   
  
  # PUT /distributor_info/admin/distributor_emails/1
  # PUT /distributor_info/admin/distributor_emails/1.xml
  def update
    respond_to do |format|
      if @distributor_email.update_attributes(distributor_email_params)
        format.html { redirect_to(admin_distributor_emails_url, notice: 'distributor email was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @distributor_email.errors, status: :unprocessable_entity }
      end
    end
  end	  
  
  def update_order
    update_list_order(DistributorInfo::DistributorEmail, params["distributor_email"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted distributor emails")
  end  
  
  # DELETE /distributor_info/admin/distributor_emails/1
  # DELETE /distributor_info/admin/distributor_emails/1.xml
  def destroy
    @called_from = params[:called_from] || "distributor"
    @distributor_email.destroy
    respond_to do |format|
      format.html { redirect_to(admin_distributor_emails_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed a email from #{@distributor_email.distributor.name}")
  end   
  
  private

	  def initialize_distributor_email
      if distributor_email_params[:contact_info_email_id].is_a?(Array)
        @distributor_emails = []
        distributor_id = distributor_email_params[:distributor_info_distributor_id]
        distributor_email_params[:contact_info_email_id].reject(&:blank?).each do |email|
          @distributor_emails << DistributorInfo::DistributorEmail.new({distributor_info_distributor_id: distributor_id, contact_info_email_id: email})
        end        
      elsif distributor_email_params[:distributor_info_distributor_id].is_a?(Array)
        @distributor_emails = []
        email_id = distributor_email_params[:contact_info_email_id]
        distributor_email_params[:distributor_info_distributor_id].reject(&:blank?).each do |distributor|
          @distributor_emails << DistributorInfo::DistributorEmail.new({distributor_info_distributor_id: distributor, contact_info_email_id: email_id})
        end
      end	 	    
	  end  #  def initialize_distributor_email  
  
    def load_distributor_email
      @distributor_email = DistributorInfo::DistributorEmail.find(params[:id])
    end 	
	
	  def distributor_email_params
	    params.require(:distributor_info_distributor_email).permit!
	  end   
  
end  #  class DistributorInfo::Admin::DistributorEmailsController < DistributorInfo::AdminController
