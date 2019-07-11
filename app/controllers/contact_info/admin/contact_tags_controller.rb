class ContactInfo::Admin::ContactTagsController < ContactInfo::AdminController
	before_action :initialize_contact_tag, only: :create
	before_action :load_contact_tag, only: [:destroy]  
	
  # GET /contact_info/admin/contact_tags/new
  # GET /contact_info/admin/contact_tags/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @contact_tag }
    end
  end
  
  # POST /contact_info/admin/contact_tags
  # POST /contact_info/admin/contact_tags.xml
  def create
    @called_from = params[:called_from] || "contact"
    respond_to do |format|
      if @contact_tags.present?
        begin
          @contact_tags.each do |contact_tag|
            begin
              contact_tag.save!
              @contact_tag = contact_tag
              add_log(user: current_user, action: "Associated #{contact_tag.contact.name} with #{contact_tag.tag.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{contact_tag.tag.name}"
              format.js { render template: "/contact_info/admin/contact_tags/create_error" }
            end
          end  #  @contact_tags.each do |contact_tag|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/contact_info/admin/contact_tags/create_error" }
        end        
      else       
          @error = "No tags provided."
          format.html { render action: "new" }
          format.xml  { render xml: @contact_tag.errors, status: :unprocessable_entity }
          format.js { render template: "/contact_info/admin/contact_tags/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create
  
  # PUT /contact_info/admin/contact_tags/1
  # PUT /contact_info/admin/contact_tags/1.xml
  def update
    respond_to do |format|
      if @contact_tag.update_attributes(contact_tag_params)
        format.html { redirect_to(admin_contact_tags_url, notice: 'Contact tag was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @contact_tag.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_order
    update_list_order(ContactInfo::ContactTag, params["contact_tag"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted contact tags")
  end 
  
  # DELETE /contact_info/admin/contact_tags/1
  # DELETE /contact_info/admin/contact_tags/1.xml
  def destroy
    @called_from = params[:called_from] || "contact"
    @contact_tag.destroy
    respond_to do |format|
      format.html { redirect_to(admin_contact_tags_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed a tag from #{@contact_tag.contact.name}")
  end 
  
  private

	  def initialize_contact_tag
      if contact_tag_params[:contact_info_tag_id].is_a?(Array)
        @contact_tags = []
        contact_id = contact_tag_params[:contact_info_contact_id]
        contact_tag_params[:contact_info_tag_id].reject(&:blank?).each do |tag|
          @contact_tags << ContactInfo::ContactTag.new({contact_info_contact_id: contact_id, contact_info_tag_id: tag})
        end        
      elsif contact_tag_params[:contact_info_contact_id].is_a?(Array)
        @contact_tags = []
        tag_id = contact_tag_params[:contact_info_tag_id]
        contact_tag_params[:contact_info_contact_id].reject(&:blank?).each do |contact|
          @contact_tags << ContactInfo::ContactTag.new({contact_info_contact_id: contact, contact_info_tag_id: tag_id})
        end
      end	 	    
	  end  #  def initialize_contact_tag
	  
    def load_contact_tag
      @contact_tag = ContactInfo::ContactTag.find(params[:id])
    end 	
	
	  def contact_tag_params
	    params.require(:contact_info_contact_tag).permit!
	  end 	  
end  #  class ContactInfo::Admin::ContactTagsController < ContactInfo::AdminController
