class ContactInfo::Admin::ContactWebsitesController < ContactInfo::AdminController
	before_action :initialize_contact_website, only: :create
	before_action :load_contact_website, only: [:destroy]  
	
  # GET /contact_info/admin/contact_websites/new
  # GET /contact_info/admin/contact_websites/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @contact_website }
    end
  end	
	
  # POST /contact_info/admin/contact_websites
  # POST /contact_info/admin/contact_websites.xml
  def create
    @called_from = params[:called_from] || "contact"
    respond_to do |format|
      if @contact_websites.present?
        begin
          @contact_websites.each do |contact_website|
            begin
              contact_website.save!
              @contact_website = contact_website
              # website.add_log(user: current_user, action: "Associated #{contact_website.contact.name} with #{contact_website.website.url}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{contact_website.website.url}"
              format.js { render template: "/contact_info/admin/contact_websites/create_error" }
            end
          end  #  @contact_websites.each do |contact_website|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/contact_info/admin/contact_websites/create_error" }
        end        
      else       
          @error = "No websites provided."
          format.html { render action: "new" }
          format.xml  { render xml: @contact_website.errors, status: :unprocessable_entity }
          format.js { render template: "/contact_info/admin/contact_websites/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create	
	
  # PUT /contact_info/admin/contact_websites/1
  # PUT /contact_info/admin/contact_websites/1.xml
  def update
    respond_to do |format|
      if @contact_website.update_attributes(contact_website_params)
        format.html { redirect_to(admin_contact_websites_url, notice: 'Contact website was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @contact_website.errors, status: :unprocessable_entity }
      end
    end
  end	
	
  def update_order
    update_list_order(ContactInfo::ContactWebsite, params["contact_website"]) # update_list_order is in application_controller
    head :ok
    # website.add_log(user: current_user, action: "Sorted contact websites")
  end 	
	
  # DELETE /contact_info/admin/contact_websites/1
  # DELETE /contact_info/admin/contact_websites/1.xml
  def destroy
    @called_from = params[:called_from] || "contact"
    @contact_website.destroy
    respond_to do |format|
      format.html { redirect_to(admin_contact_websites_url) }
      format.xml  { head :ok }
      format.js 
    end
    # website.add_log(user: current_user, action: "Removed a website from #{@contact_website.contact.name}")
  end	
  
  private

	  def initialize_contact_website
      if contact_website_params[:contact_info_website_id].is_a?(Array)
        @contact_websites = []
        contact_id = contact_website_params[:contact_info_contact_id]
        contact_website_params[:contact_info_website_id].reject(&:blank?).each do |website|
          @contact_websites << ContactInfo::ContactWebsite.new({contact_info_contact_id: contact_id, contact_info_website_id: website})
        end        
      elsif contact_website_params[:contact_info_contact_id].is_a?(Array)
        @contact_websites = []
        website_id = contact_website_params[:contact_info_website_id]
        contact_website_params[:contact_info_contact_id].reject(&:blank?).each do |contact|
          @contact_websites << ContactInfo::ContactWebsite.new({contact_info_contact_id: contact, contact_info_website_id: website_id})
        end
      end	 	    
	  end  #  def initialize_contact_website  
	
    def load_contact_website
      @contact_website = ContactInfo::ContactWebsite.find(params[:id])
    end 	
	
	  def contact_website_params
	    params.require(:contact_info_contact_website).permit!
	  end 	
	
end  #  class ContactInfo::Admin::ContactWebsitesController < ContactInfo::AdminController
