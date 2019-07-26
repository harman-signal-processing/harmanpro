class ContactInfo::Admin::WebsitesController < ContactInfo::AdminController
  before_action :load_website, only: [:edit, :update, :destroy]
  
  def index
    @websites = ContactInfo::Website.all.order(:url)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @websites }
      format.json  { render json: @websites }
    end    
  end
  
  def new
    contact_id = params[:website][:contact_id] unless params[:website].nil?
    @contact = ContactInfo::Contact.find(contact_id) if contact_id.present?
    
    distributor_id = params[:website][:distributor_id] unless params[:website].nil?
    @distributor = DistributorInfo::Distributor.find(distributor_id) if distributor_id.present?
    
    location_id = params[:website][:location_id] unless params[:website].nil?
    @location = LocationInfo::Location.find(location_id) if location_id.present?
    
    @website = ContactInfo::Website.new
  end  
  
  def edit
    @contact_website = ContactInfo::ContactWebsite.new(contact_info_website_id: @website.id)
    @contact_websites = ContactInfo::ContactWebsite.where(contact_info_website_id: @website.id)
    
    @distributor_website = DistributorInfo::DistributorWebsite.new(contact_info_website_id: @website.id)
    @distributor_websites = DistributorInfo::DistributorWebsite.where(contact_info_website_id: @website.id)
    
    @location_website = LocationInfo::LocationWebsite.new(contact_info_website_id: @website.id)
    @location_websites = LocationInfo::LocationWebsite.where(contact_info_website_id: @website.id)
  end  
  
  def update
    respond_to do |format|
      if @website.update_attributes({url: website_params[:url], label: website_params[:label]})
        format.html { redirect_to(contact_info_admin_websites_path, notice: "Website #{@website.url} was successfully updated.") }
        format.xml  { head :ok }
        add_log(user: current_user, action: "Updated website: #{@website.url}")
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @website.errors, status: :unprocessable_entity }
      end
    end 
  end  
  
  def create
    @website = ContactInfo::Website.new({url: website_params[:url], label: website_params[:label]})
    @contact = website_params[:contact_id].present? ? ContactInfo::Contact.find(website_params[:contact_id]) : nil
    @distributor = website_params[:distributor_id].present? ? DistributorInfo::Distributor.find(website_params[:distributor_id]) : nil
    @location = website_params[:location_id].present? ? LocationInfo::Location.find(website_params[:location_id]) : nil
    respond_to do |format|
      if @website.save

        if @contact.present?
          @website.contacts << @contact unless @contact.nil?
          add_log(user: current_user, action: "Created website #{@website.url} and associated to contact #{@contact.name}")
          format.html { redirect_to(edit_contact_info_admin_contact_path(@contact), notice: "Website #{@website.url} was successfully created and associated to #{@contact.name}.") }
        elsif @distributor.present?
          @website.distributors << @distributor unless @distributor.nil?
          add_log(user: current_user, action: "Created website #{@website.url} and associated to distributor #{@distributor.name}")
          format.html { redirect_to(edit_distributor_info_admin_distributor_path(@distributor), notice: "Website #{@website.url} was successfully created and associated to #{@distributor.name}.") }          
        elsif @location.present?
          @website.locations << @location unless @location.nil?
          add_log(user: current_user, action: "Created website #{@website.url} and associated to location #{@location.name}")
          format.html { redirect_to(edit_location_info_admin_location_path(@location), notice: "Website #{@website.url} was successfully created and associated to #{@location.name}.") }          
        else
          add_log(user: current_user, action: "Created website #{@website.url}")
          format.html { redirect_to(contact_info_admin_websites_path, notice: "Website #{@website.url} was successfully created.") }
        end

        format.xml  { render xml: @website, status: :created, location: @website }
        format.js # Not really applicable because the attachment can't be sent via AJAX
        add_log(user: current_user, action: "Created website #{@website.url}")
      else
        format.html { redirect_to(contact_info_admin_websites_path, notice: "There was a problem creating the Website #{@website.url}.") }
        format.xml  { render xml: @website.errors, status: :unprocessable_entity }
        format.js { render plain: "Error" }
      end
    end      
  end  
  
  # DELETE /contact_info/admin/websites/1
  # DELETE /contact_info/admin/websites/1.xml
  def destroy
    @website.destroy
    respond_to do |format|
      format.html { redirect_to(contact_info_admin_websites_url) }
      format.xml  { head :ok }
    end
    add_log(user: current_user, action: "Deleted website: #{@website.url}")
  end     
  
  private
  
    def load_website
      @website = ContactInfo::Website.find(params[:id])
    end   
  
    def website_params
  	  params.require(:contact_info_website).permit(:url, :label, :contact_id, :distributor_id, :location_id)
    end    
end  #  class ContactInfo::Admin::WebsitesController < ContactInfo::AdminController
