class ContactInfo::Admin::ContactSupportedBrandsController < ContactInfo::AdminController
	before_action :initialize_contact_supported_brand, only: :create
	before_action :load_contact_supported_brand, only: [:destroy]   
	
  # GET /contact_info/admin/contact_supported_brands/new
  # GET /contact_info/admin/contact_supported_brands/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @contact_supported_brand }
    end
  end
  
  # POST /contact_info/admin/contact_supported_brands
  # POST /contact_info/admin/contact_supported_brands.xml
  def create
    @called_from = params[:called_from] || "contact"
    respond_to do |format|
      if @contact_supported_brands.present?
        begin
          @contact_supported_brands.each do |contact_supported_brand|
            begin
              contact_supported_brand.save!
              @contact_supported_brand = contact_supported_brand
              add_log(user: current_user, action: "Associated #{contact_supported_brand.contact.name} with #{contact_supported_brand.brand.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{contact_supported_brand.brand.name}"
              format.js { render template: "/contact_info/admin/contact_supported_brands/create_error" }
            end
          end  #  @contact_supported_brands.each do |contact_supported_brand|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/contact_info/admin/contact_supported_brands/create_error" }
        end        
      else       
          @error = "No contact_supported_brands provided."
          format.html { render action: "new" }
          format.xml  { render xml: @contact_supported_brand.errors, status: :unprocessable_entity }
          format.js { render template: "/contact_info/admin/contact_supported_brands/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create   
  
  # PUT /contact_info/admin/contact_supported_brands/1
  # PUT /contact_info/admin/contact_supported_brands/1.xml
  def update
    respond_to do |format|
      if @contact_supported_brand.update_attributes(contact_supported_brand_params)
        format.html { redirect_to(admin_contact_supported_brands_url, notice: 'Contact supported_brand was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @contact_supported_brand.errors, status: :unprocessable_entity }
      end
    end
  end   
  
  def update_order
    update_list_order(ContactInfo::ContactSupportedBrand, params["contact_supported_brand"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted contact supported_brands")
  end  
  
  # DELETE /contact_info/admin/contact_supported_brands/1
  # DELETE /contact_info/admin/contact_supported_brands/1.xml
  def destroy
    @called_from = params[:called_from] || "contact"
    @contact_supported_brand.destroy
    respond_to do |format|
      format.html { redirect_to(admin_contact_supported_brands_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed #{@contact_supported_brand.brand.name} from #{@contact_supported_brand.contact.name}")
  end  
  
  private

	  def initialize_contact_supported_brand
      if contact_supported_brand_params[:brand_id].is_a?(Array)
        @contact_supported_brands = []
        contact_id = contact_supported_brand_params[:contact_info_contact_id]
        contact_supported_brand_params[:brand_id].reject(&:blank?).each do |supported_brand|
          @contact_supported_brands << ContactInfo::ContactSupportedBrand.new({contact_info_contact_id: contact_id, brand_id: supported_brand})
        end        
      elsif contact_supported_brand_params[:contact_info_contact_id].is_a?(Array)
        @contact_supported_brands = []
        supported_brand_id = contact_supported_brand_params[:brand_id]
        contact_supported_brand_params[:contact_info_contact_id].reject(&:blank?).each do |contact|
          @contact_supported_brands << ContactInfo::ContactSupportedBrand.new({contact_info_contact_id: contact, brand_id: supported_brand_id})
        end
      end	 	    
	  end  #  def initialize_contact_supported_brand   
  
    def load_contact_supported_brand
      @contact_supported_brand = ContactInfo::ContactSupportedBrand.find(params[:id])
    end 	
	
	  def contact_supported_brand_params
	    params.require(:contact_info_contact_supported_brand).permit!
	  end    
  
end  #  class ContactInfo::Admin::ContactSupportedBrandsController < ContactInfo::AdminController
