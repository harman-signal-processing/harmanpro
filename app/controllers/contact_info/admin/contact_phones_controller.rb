class ContactInfo::Admin::ContactPhonesController < ContactInfo::AdminController
	before_action :initialize_contact_phone, only: :create
	before_action :load_contact_phone, only: [:destroy]
  # load_and_authorize_resource class: "ContactInfo::Phone", except: [:update_order]
  # skip_authorization_check only: [:update_order]

  # GET /contact_info/admin/contact_phones/new
  # GET /contact_info/admin/contact_phones/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @contact_phone }
    end
  end


  # POST /contact_info/admin/contact_phones
  # POST /contact_info/admin/contact_phones.xml
  def create
    @called_from = params[:called_from] || "contact"
    respond_to do |format|
      if @contact_phones.present?
        begin
          @contact_phones.each do |contact_phone|
            begin
              contact_phone.save!
              @contact_phone = contact_phone
              add_log(user: current_user, action: "Associated #{contact_phone.contact.name} with #{contact_phone.phone.phone}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{contact_phone.phone.phone}"
              format.js { render template: "/contact_info/admin/contact_phones/create_error" }
            end
          end  #  @contact_phones.each do |contact_phone|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/contact_info/admin/contact_phones/create_error" }
        end        
      else       
          @error = "No phones provided."
          format.html { render action: "new" }
          format.xml  { render xml: @contact_phone.errors, status: :unprocessable_entity }
          format.js { render template: "/contact_info/admin/contact_phones/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create

  # PUT /contact_info/admin/contact_phones/1
  # PUT /contact_info/admin/contact_phones/1.xml
  def update
    respond_to do |format|
      if @contact_phone.update(contact_phone_params)
        format.html { redirect_to(admin_contact_phones_url, notice: 'Contact phone was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @contact_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_order
    update_list_order(ContactInfo::ContactPhone, params["contact_phone"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted contact phones")
  end 

  # DELETE /contact_info/admin/contact_phones/1
  # DELETE /contact_info/admin/contact_phones/1.xml
  def destroy
    @called_from = params[:called_from] || "contact"
    @contact_phone.destroy
    respond_to do |format|
      format.html { redirect_to(admin_contact_phones_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed #{@contact_phone.phone.phone} from #{@contact_phone.contact.name}")
  end 

  private

	  def initialize_contact_phone
      if contact_phone_params[:contact_info_phone_id].is_a?(Array)
        @contact_phones = []
        contact_id = contact_phone_params[:contact_info_contact_id]
        contact_phone_params[:contact_info_phone_id].reject(&:blank?).each do |phone|
          @contact_phones << ContactInfo::ContactPhone.new({contact_info_contact_id: contact_id, contact_info_phone_id: phone})
        end        
      elsif contact_phone_params[:contact_info_contact_id].is_a?(Array)
        @contact_phones = []
        phone_id = contact_phone_params[:contact_info_phone_id]
        contact_phone_params[:contact_info_contact_id].reject(&:blank?).each do |contact|
          @contact_phones << ContactInfo::ContactPhone.new({contact_info_contact_id: contact, contact_info_phone_id: phone_id})
        end
      end	 	    
	  end  #  def initialize_contact_phone
	
    def load_contact_phone
      @contact_phone = ContactInfo::ContactPhone.find(params[:id])
    end 	
	
	  def contact_phone_params
	    params.require(:contact_info_contact_phone).permit!
	  end  
end  #  class ContactInfo::Admin::ContactPhonesController < ContactInfo::AdminController
