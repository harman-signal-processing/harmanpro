class DistributorInfo::Admin::DistributorsController < DistributorInfo::AdminController
  before_action :load_distributor, except: [:index, :new, :create]
  
  def index
    @distributors = DistributorInfo::Distributor.all
  end   
  
  def new
    contact_id = params[:distributor][:contact_id] unless params[:distributor].nil?
    @contact = ContactInfo::Contact.find(contact_id) if contact_id.present?
    
    email_id = params[:distributor][:email_id] unless params[:distributor].nil?
    @email = ContactInfo::Email.find(email_id) if email_id.present?    
    
    phone_id = params[:distributor][:phone_id] unless params[:distributor].nil?
    @phone = ContactInfo::Phone.find(phone_id) if phone_id.present?     
    
    website_id = params[:distributor][:website_id] unless params[:distributor].nil?
    @website = ContactInfo::Website.find(website_id) if website_id.present?     
    
    location_id = params[:distributor][:location_id] unless params[:distributor].nil?
    @location = LocationInfo::Location.find(location_id) if location_id.present? 
    
    @distributor = DistributorInfo::Distributor.new
  end  
  
  def edit
    @distributor_location = DistributorInfo::DistributorLocation.new(distributor_info_distributor_id: @distributor.id)
    @distributor_locations = DistributorInfo::DistributorLocation.where(distributor_info_distributor_id: @distributor.id)  
    
    @distributor_contact = DistributorInfo::DistributorContact.new(distributor_info_distributor_id: @distributor.id)
    @distributor_contacts = DistributorInfo::DistributorContact.where(distributor_info_distributor_id: @distributor.id)     
    
    @distributor_email = DistributorInfo::DistributorEmail.new(distributor_info_distributor_id: @distributor.id)
    @distributor_emails = DistributorInfo::DistributorEmail.where(distributor_info_distributor_id: @distributor.id)    
    
    @distributor_phone = DistributorInfo::DistributorPhone.new(distributor_info_distributor_id: @distributor.id)
    @distributor_phones = DistributorInfo::DistributorPhone.where(distributor_info_distributor_id: @distributor.id)    
    
    @distributor_website = DistributorInfo::DistributorWebsite.new(distributor_info_distributor_id: @distributor.id)
    @distributor_websites = DistributorInfo::DistributorWebsite.where(distributor_info_distributor_id: @distributor.id)    
    
    @distributor_brand = DistributorInfo::DistributorBrand.new(distributor_info_distributor_id: @distributor.id)
    @distributor_brands = DistributorInfo::DistributorBrand.where(distributor_info_distributor_id: @distributor.id)
    
    @distributor_country = DistributorInfo::DistributorCountry.new(distributor_info_distributor_id: @distributor.id)
    @distributor_countries = DistributorInfo::DistributorCountry.where(distributor_info_distributor_id: @distributor.id)    
  end  
  
  def create
    @distributor = DistributorInfo::Distributor.new(distributor_params.except(:location_id, :contact_id))
    @contact = distributor_params[:contact_id].present? ? ContactInfo::Contact.find(distributor_params[:contact_id]) : nil
    @location = distributor_params[:location_id].present? ? LocationInfo::Location.find(distributor_params[:location_id]) : nil
    
    if @distributor.save
      if @contact.present?
        @distributor.contacts << @contact
        redirect_to edit_contact_info_admin_contact_path(@contact), notice: "The distributor #{@distributor.name} was created successfully and assocated to #{@contact.name}."
      elsif @location.present?
        @distributor.locations << @location
        redirect_to edit_location_info_admin_location_path(@location), notice: "The distributor #{@distributor.name} was created successfully and associated to #{@location.name}."      
      else
        redirect_to edit_distributor_info_admin_distributor_path(@distributor), notice: "The distributor #{@distributor.name} was created successfully."
      end
    else
      render action: :new
    end
  end
  
  def update
    if @distributor.update_attributes(distributor_params)
      redirect_to distributor_info_admin_distributors_path
    else
      render action: :edit
    end    
  end
  
  def destroy
    if @distributor.destroy
      redirect_to distributor_info_admin_distributors_path
    end    
  end  
  
  private
  
  def load_distributor
    @distributor = DistributorInfo::Distributor.find(params[:id])
  end  
  
  def distributor_params
    params.require(:distributor_info_distributor).permit(:name, :account_number, :contact_id, :location_id, :email_id, :phone_id, :website_id)
  end   
  
end  #  class DistributorInfo::Admin::DistributorsController < DistributorInfo::AdminController
