class ContactInfo::Admin::ContactsController < ContactInfo::AdminController
  before_action :load_contact, except: [:index, :new, :create]
  
  def index
    @contacts = ContactInfo::Contact.all
  end  
  
  def new
    email_id = params[:contact][:email_id] unless params[:contact].nil?
    @email = ContactInfo::Email.find(email_id) if email_id.present?
    
    phone_id = params[:contact][:phone_id] unless params[:contact].nil?
    @phone = ContactInfo::Phone.find(phone_id) if phone_id.present?
      
    website_id = params[:contact][:website_id] unless params[:contact].nil?
    @website = ContactInfo::Website.find(website_id) if website_id.present?      
    
    team_group_id = params[:contact][:team_group_id] unless params[:contact].nil?
    @team_group = ContactInfo::TeamGroup.find(team_group_id) if team_group_id.present?    
    
    territory_id = params[:contact][:territory_id] unless params[:contact].nil?
    @territory = ContactInfo::Territory.find(territory_id) if territory_id.present?  
    
    tag_id = params[:contact][:tag_id] unless params[:contact].nil?
    @tag = ContactInfo::Tag.find(tag_id) if tag_id.present?    
    
    data_client_id = params[:contact][:data_client_id] unless params[:contact].nil?
    @data_client = ContactInfo::DataClient.find(data_client_id) if data_client_id.present?     
    
    distributor_id = params[:contact][:distributor_id] unless params[:contact].nil?
    @distributor = DistributorInfo::Distributor.find(distributor_id) if distributor_id.present?    
    
    location_id = params[:contact][:location_id] unless params[:contact].nil?
    @location = LocationInfo::Location.find(location_id) if location_id.present?     
    
    @contact = ContactInfo::Contact.new
  end  #  def new

  def edit
    @contact_email = ContactInfo::ContactEmail.new(contact_info_contact_id: @contact.id)
    @contact_emails = ContactInfo::ContactEmail.where(contact_info_contact_id: @contact.id)
    
    @contact_phone = ContactInfo::ContactPhone.new(contact_info_contact_id: @contact.id)
    @contact_phones = ContactInfo::ContactPhone.where(contact_info_contact_id: @contact.id)    

    @contact_website = ContactInfo::ContactWebsite.new(contact_info_contact_id: @contact.id)
    @contact_websites = ContactInfo::ContactWebsite.where(contact_info_contact_id: @contact.id)   
    
    @contact_team_group = ContactInfo::ContactTeamGroup.new(contact_info_contact_id: @contact.id)
    @contact_team_groups = ContactInfo::ContactTeamGroup.joins(:team_group).where(contact_info_contact_id: @contact.id).order('contact_info_team_groups.name')
    
    @contact_territory = ContactInfo::ContactTerritory.new(contact_info_contact_id: @contact.id)
    @contact_territories = ContactInfo::ContactTerritory.joins(:territory).where(contact_info_contact_id: @contact.id).order('contact_info_territories.name')
    
    @contact_tag = ContactInfo::ContactTag.new(contact_info_contact_id: @contact.id)
    @contact_tags = ContactInfo::ContactTag.joins(:tag).where(contact_info_contact_id: @contact.id).order('contact_info_tags.name') 
    
    @contact_data_client = ContactInfo::ContactDataClient.new(contact_info_contact_id: @contact.id)
    @contact_data_clients = ContactInfo::ContactDataClient.joins(:data_client).where(contact_info_contact_id: @contact.id).order('contact_info_data_clients.name')
    
    @contact_email = ContactInfo::ContactEmail.new(contact_info_contact_id: @contact.id)
    @contact_emails = ContactInfo::ContactEmail.where(contact_info_contact_id: @contact.id)    
    
    @location_contact = LocationInfo::LocationContact.new(contact_info_contact_id: @contact.id)
    @location_contacts = LocationInfo::LocationContact.where(contact_info_contact_id: @contact.id)     
    
    @distributor_contact = DistributorInfo::DistributorContact.new(contact_info_contact_id: @contact.id)
    @distributor_contacts = DistributorInfo::DistributorContact.where(contact_info_contact_id: @contact.id)    
    
    @contact_supported_brand = ContactInfo::ContactSupportedBrand.new(contact_info_contact_id: @contact.id)
    @contact_supported_brands = ContactInfo::ContactSupportedBrand.where(contact_info_contact_id: @contact.id)     
    
    @contact_supported_country = ContactInfo::ContactSupportedCountry.new(contact_info_contact_id: @contact.id)
    @contact_supported_countries = ContactInfo::ContactSupportedCountry.where(contact_info_contact_id: @contact.id)    
    
    @is_pro_site_contact = @contact.data_clients.map{|client| client.name == "pro.harman.com/contacts"}.any?
    @is_brandsite_support_rso = @contact.data_clients.map{|client| client.name == "brandsite/support/rsos"}.any?
    @is_brandsite_distributor = @contact.data_clients.map{|client| client.name == "brandsite/distributors"}.any?
    
    @supports_specific_brands = !@contact.supported_brands.empty?
    @supports_specific_countries = !@contact.supported_countries.empty?
    
  end  #  def edit
  
  def create
    @contact = ContactInfo::Contact.new({name: contact_params[:name], title: contact_params[:title]})
    @email = contact_params[:email_id].present? ? ContactInfo::Email.find(contact_params[:email_id]) : nil
    @phone = contact_params[:phone_id].present? ? ContactInfo::Phone.find(contact_params[:phone_id]) : nil
    @website = contact_params[:website_id].present? ? ContactInfo::Website.find(contact_params[:website_id]) : nil
    @team_group = contact_params[:team_group_id].present? ? ContactInfo::TeamGroup.find(contact_params[:team_group_id]) : nil
    @territory = contact_params[:territory_id].present? ? ContactInfo::Territory.find(contact_params[:territory_id]) : nil
    
    @distributor = contact_params[:distributor_id].present? ? DistributorInfo::Distributor.find(contact_params[:distributor_id]) : nil
    @location = contact_params[:location_id].present? ? LocationInfo::Location.find(contact_params[:location_id]) : nil
    
    if @contact.save
      
      @contact.emails << @email unless @email.nil?
      @contact.phones << @phone unless @phone.nil?
      @contact.websites << @website unless @website.nil?
      @contact.team_groups << @team_group unless @team_group.nil?
      @contact.territories << @territory unless @territory.nil?
      @contact.distributors << @distributor unless @distributor.nil?
      
      if @location.present?
        @contact.locations << @location unless @location.nil?
        add_log(user: current_user, action: "Created #{@contact.name} and associated with location #{@location.name}")
        redirect_to(edit_location_info_admin_location_path(@location), notice: "Contact #{@contact.name} was successfully created and associated to #{@location.name}.") 
      else      
        add_log(user: current_user, action: "Created contact #{@contact.name}")
        redirect_to edit_contact_info_admin_contact_path(@contact), notice: "The contact #{@contact.name} was created successfully."
      end
    else
      render action: :new
    end     
  end
  
  def update
    if @contact.update_attributes(contact_params)
      add_log(user: current_user, action: "Updated contact #{@contact.name}")
      redirect_to contact_info_admin_contacts_path
    else
      render action: :edit
    end
  end  
  
  def destroy
    if @contact.destroy
      add_log(user: current_user, action: "Deleted contact #{@contact.name}")
      redirect_to contact_info_admin_contacts_path
    end
  end

  private

  def load_contact
    @contact = ContactInfo::Contact.find(params[:id])
    
    # This is so the edit page will not complain
    @contact.pro_site_options = ContactInfo::ContactProSiteOption.new if @contact.pro_site_options.nil?
    #authorize @contact
  end  
  
  def contact_params
    params.require(:contact_info_contact).permit(:name, :title, :email_id, :phone_id, :website_id, :team_group_id, :territory_id, :tag_id, :data_client_id, :distributor_id, :location_id)
  end  
  
end  #  class ContactInfo::Admin::ContactsController < ApplicationController
