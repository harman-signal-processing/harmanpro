class DistributorInfo::Admin::DistributorsController < DistributorInfo::AdminController
  before_action :load_distributor, except: [:index, :new, :create]

  def index
    @distributor_id = params[:distributor_id] if params[:distributor_id].present?
    @region_id = params[:region_id] if params[:region_id].present?
    @country_id = params[:country_id] if params[:country_id].present?
    @brand_id = params[:brand_id] if params[:brand_id].present?
    show_all = params[:show_all].present?

    filter_in_use = @distributor_id.present? || @region_id.present? || @country_id.present? || @brand_id.present?

    if filter_in_use
      if @distributor_id.present?
        distributor = DistributorInfo::Distributor.find(@distributor_id)
        @distributors = [] << distributor
        @filtered_by = distributor.name
        @result_count = 1
      elsif @region_id.present?
        location_ids = LocationInfo::Location.joins(:regions).where("location_info_regions.id = ?", @region_id).ids
        @distributors = DistributorInfo::Distributor.joins(:locations).where("distributor_info_distributor_locations.location_info_location_id in (?)", location_ids).order(:name)
        @filtered_by = LocationInfo::Region.find(@region_id).name
        @result_count = @distributors.count
      elsif @country_id.present?
        @distributors = DistributorInfo::Distributor.joins(:countries).where("location_info_countries.id = ?", @country_id).order(:name)
        @filtered_by = LocationInfo::Country.find(@country_id).name
        @result_count = @distributors.count
      elsif @brand_id.present?
        @distributors = DistributorInfo::Distributor.joins(:brands).where("brands.id = ?", @brand_id).order(:name)
        @filtered_by = Brand.find(@brand_id).name
        @result_count = @distributors.count
      end

    elsif show_all
      @distributors = DistributorInfo::Distributor.all.order(:name)
      @filtered_by = "All"
      @result_count = @distributors.count
    else
      # don't show all be default
    end  #  if filter_in_use

    @results_message = "Showing <strong>#{@result_count}</strong> Distributors for <strong>#{@filtered_by}</strong>"

  end  #  def index

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

    @distributor_exclude_brand_country = DistributorInfo::DistributorExcludeBrandCountry.new(distributor_info_distributor_id: @distributor.id)
    @distributor_exclude_brand_countries = DistributorInfo::DistributorExcludeBrandCountry.where(distributor_info_distributor_id: @distributor.id)

  end

  def create
    @distributor = DistributorInfo::Distributor.new(distributor_params.except(:location_id, :contact_id))
    @contact = distributor_params[:contact_id].present? ? ContactInfo::Contact.find(distributor_params[:contact_id]) : nil
    @location = distributor_params[:location_id].present? ? LocationInfo::Location.find(distributor_params[:location_id]) : nil

    if @distributor.save
      if @contact.present?
        @distributor.contacts << @contact
        add_log(user: current_user, action: "Associated #{@distributor.name} to #{@contact.name}")
        redirect_to edit_contact_info_admin_contact_path(@contact), notice: "The distributor #{@distributor.name} was created successfully and assocated to #{@contact.name}."
      elsif @location.present?
        @distributor.locations << @location
        add_log(user: current_user, action: "Associated #{@location.name} to #{@distributor.name}")
        redirect_to edit_location_info_admin_location_path(@location), notice: "The distributor #{@distributor.name} was created successfully and associated to #{@location.name}."
      else
        add_log(user: current_user, action: "Created distributor #{@distributor.name}")
        redirect_to edit_distributor_info_admin_distributor_path(@distributor), notice: "The distributor #{@distributor.name} was created successfully."
      end
    else
      render action: :new
    end
  end

  def update
    if @distributor.update(distributor_params)
      add_log(user: current_user, action: "Updated distributor #{@distributor.name}")
      redirect_to distributor_info_admin_distributors_path
    else
      render action: :edit
    end
  end

  def destroy
    if @distributor.destroy
      add_log(user: current_user, action: "Deleted distributor #{@distributor.name}")
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
