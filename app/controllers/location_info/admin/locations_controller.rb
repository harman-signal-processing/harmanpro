class LocationInfo::Admin::LocationsController < LocationInfo::AdminController
  before_action :load_location, except: [:index, :new, :create]
  
  def index
    @locations = LocationInfo::Location.all
  end   
  
  def new
    contact_id = params[:location][:contact_id] unless params[:location].nil?
    @contact = ContactInfo::Contact.find(contact_id) if contact_id.present?
    
    email_id = params[:location][:email_id] unless params[:location].nil?
    @email = ContactInfo::Email.find(email_id) if email_id.present?
    
    phone_id = params[:location][:phone_id] unless params[:location].nil?
    @phone = ContactInfo::Phone.find(phone_id) if phone_id.present?
    
    website_id = params[:location][:website_id] unless params[:location].nil?
    @website = ContactInfo::Website.find(website_id) if website_id.present?    
    
    distributor_id = params[:location][:distributor_id] unless params[:location].nil?
    @distributor = DistributorInfo::Distributor.find(distributor_id) if distributor_id.present?    
    
    region_id = params[:location][:region_id] unless params[:location].nil?
    @region = LocationInfo::Region.find(region_id) if region_id.present?    
    
    location_supported_country_id = params[:location][:country_id] unless params[:location].nil?
    @country = LocationInfo::Country.find(location_supported_country_id) if location_supported_country_id.present?    
    
    @location = LocationInfo::Location.new
  end
  
  def edit
    @location_region = LocationInfo::LocationRegion.new(location_info_location_id: @location.id)
    @location_regions = LocationInfo::LocationRegion.where(location_info_location_id: @location.id)  
    
    @location_contact = LocationInfo::LocationContact.new(location_info_location_id: @location.id)
    @location_contacts = LocationInfo::LocationContact.where(location_info_location_id: @location.id)     
    
    @location_email = LocationInfo::LocationEmail.new(location_info_location_id: @location.id)
    @location_emails = LocationInfo::LocationEmail.where(location_info_location_id: @location.id)     
    
    @location_phone = LocationInfo::LocationPhone.new(location_info_location_id: @location.id)
    @location_phones = LocationInfo::LocationPhone.where(location_info_location_id: @location.id)     
    
    @location_website = LocationInfo::LocationWebsite.new(location_info_location_id: @location.id)
    @location_websites = LocationInfo::LocationWebsite.where(location_info_location_id: @location.id)     
    
    @distributor_location = DistributorInfo::DistributorLocation.new(location_info_location_id: @location.id)
    @distributor_locations = DistributorInfo::DistributorLocation.where(location_info_location_id: @location.id)    
    
    @location_supported_country = LocationInfo::LocationSupportedCountry.new(location_info_location_id: @location.id)
    @location_supported_countries = LocationInfo::LocationSupportedCountry.where(location_info_location_id: @location.id)    
    
    @location_supported_brand = LocationInfo::LocationSupportedBrand.new(location_info_location_id: @location.id)
    @location_supported_brands = LocationInfo::LocationSupportedBrand.where(location_info_location_id: @location.id)    
       
    @location_exclude_brand_country = LocationInfo::LocationExcludeBrandCountry.new(location_info_location_id: @location.id)
    @location_exclude_brand_countries = LocationInfo::LocationExcludeBrandCountry.where(location_info_location_id: @location.id)    
        
  end  #  def edit
  
  def create
    @location = LocationInfo::Location.new(location_params.except(:contact_id, :distributor_id, :region_id, :country_id, :email_id))
    @contact = location_params[:contact_id].present? ? ContactInfo::Contact.find(location_params[:contact_id]) : nil
    @email = location_params[:email_id].present? ? ContactInfo::Email.find(location_params[:email_id]) : nil
    @phone = location_params[:phone_id].present? ? ContactInfo::Phone.find(location_params[:phone_id]) : nil
    @website = location_params[:website_id].present? ? ContactInfo::Website.find(location_params[:website_id]) : nil
    @distributor = location_params[:distributor_id].present? ? DistributorInfo::Distributor.find(location_params[:distributor_id]) : nil
    @region = location_params[:region_id].present? ? LocationInfo::Region.find(location_params[:region_id]) : nil
    @country = location_params[:country_id].present? ? LocationInfo::Country.find(location_params[:country_id]) : nil

    if @location.save
      
      if @contact.present?
        @location.contacts << @contact
        redirect_to edit_contact_info_admin_contact_path(@contact), notice: "The location #{@location.name} was created successfully and assocated to #{@contact.name}."
      elsif @email.present?
        @location.emails << @email
        redirect_to edit_contact_info_admin_email_path(@email), notice: "The location #{@location.name} was created successfully and assocated to #{@email.email}."        
      elsif @phone.present?
        @location.phones << @phone
        redirect_to edit_contact_info_admin_phone_path(@phone), notice: "The location #{@location.name} was created successfully and assocated to #{@phone.phone}."              
      elsif @website.present?
        @location.websites << @website
        redirect_to edit_contact_info_admin_website_path(@website), notice: "The location #{@location.name} was created successfully and assocated to #{@website.url}."              
      elsif @distributor.present?
        @location.distributors << @distributor
        redirect_to edit_distributor_info_admin_distributor_path(@distributor), notice: "The location #{@location.name} was created successfully and associated to #{@distributor.name}."
      elsif @region.present?
        @location.regions << @region
        redirect_to edit_region_info_admin_region_path(@region), notice: "The location #{@location.name} was created successfully and associated to #{@region.name}."
      elsif @country.present?
        @location.supported_countries << @country
        redirect_to edit_location_info_admin_country_path(@country), notice: "The location #{@location.name} was created successfully and associated as supporting #{@country.name}."
      else
        redirect_to location_info_admin_locations_path, notice: "The location #{@location.name} was created successfully."
      end
      
    else
      render action: :new
    end
  end
  
  def update
    if @location.update_attributes(location_params)
      redirect_to location_info_admin_locations_path
    else
      render action: :edit
    end    
  end
  
  def destroy
    if @location.destroy
      redirect_to location_info_admin_locations_path
    end    
  end
  
  private
  
  def load_location
    @location = LocationInfo::Location.find(params[:id])
  end  
  
  def location_params
    params.require(:location_info_location).permit(:name, :account_number, :address1, :address2, :address3, :city, :state, :country, :postal, :lat, :lng, :google_map_place_id, :contact_id, :distributor_id, :region_id, :country_id, :email_id, :phone_id, :website_id)
  end   
  
end  #  class LocationInfo::Admin::LocationsController < LocationInfo::AdminController
