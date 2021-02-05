class ContactInfo::Admin::ProSiteOptionsController < ContactInfo::AdminController
  before_action :load_pro_site_option, only: [:edit, :update, :destroy]
  
  def index
    @pro_site_options = ContactInfo::ContactProSiteOption.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @pro_site_options }
      format.json  { render json: { "pro_site_options" => @pro_site_options } }
    end    
  end
  
  def new
    contact_id = params[:pro_site_option][:contact_id] unless params[:pro_site_option].nil?
    @contact = ContactInfo::Contact.find(contact_id) if contact_id.present?
    @pro_site_option = ContactInfo::ContactProSiteOption.new
  end
  
  def edit
    # @contact_pro_site_option = ContactInfo::ContactProSiteOption.new(contact_info_pro_site_option_id: @pro_site_option.id)
  end  
  
  def update
    respond_to do |format|
      if @pro_site_option.update(pro_site_option_params)
        format.html { redirect_to(contact_info_admin_pro_site_options_path, notice: "Pro Site Options update for #{@pro_site_option.contact.name} was successfully updated.") }
        format.xml  { head :ok }
        add_log(user: current_user, action: "Updated pro_site_option: #{@pro_site_option.name}")
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @pro_site_option.errors, status: :unprocessable_entity }
      end
    end 
  end
  
  def create
    @pro_site_option = ContactInfo::ContactProSiteOption.new({pro_site_option: pro_site_option_params[:name]})
    @contact = pro_site_option_params[:contact_id].present? ? ContactInfo::Contact.find(pro_site_option_params[:contact_id]) : nil
    respond_to do |format|
      if @pro_site_option.save

        @pro_site_option.contacts << @contact unless @contact.nil?

        format.html { redirect_to(contact_info_admin_pro_site_options_path, notice: "ContactProSiteOption #{@pro_site_option.name} was successfully created.") }
        format.xml  { render xml: @pro_site_option, status: :created, location: @pro_site_option }
        format.js # Not really applicable because the attachment can't be sent via AJAX
        add_log(user: current_user, action: "Created pro_site_option #{@pro_site_option.name}")
      else
        format.html { redirect_to(contact_info_admin_pro_site_options_path, notice: "There was a problem creating the ProSiteOption #{@pro_site_option.name}.") }
        format.xml  { render xml: @pro_site_option.errors, status: :unprocessable_entity }
        format.js { render plain: "Error" }
      end
    end      
  end  
  
    # DELETE /contact_info/admin/pro_site_options/1
  # DELETE /contact_info/admin/pro_site_options/1.xml
  def destroy
    @pro_site_option.destroy
    respond_to do |format|
      format.html { redirect_to(contact_info_admin_pro_site_options_url) }
      format.xml  { head :ok }
    end
    add_log(user: current_user, action: "Deleted pro_site_option: #{@pro_site_option.name}")
  end
  
  private
  
    def load_pro_site_option
      @pro_site_option = ContactInfo::Contact.find(params[:id]).pro_site_options
    end   
  
    def pro_site_option_params
  	  params.require(:contact_info_contact_pro_site_option).permit(:showonweb, :showforsolutions, :showforchannels, :contact_info_contact_id)
    end   
  
end  #  class ContactInfo::Admin::ProSiteOptionsController < ContactInfo::AdminController
