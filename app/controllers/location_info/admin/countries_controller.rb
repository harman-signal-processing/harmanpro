class LocationInfo::Admin::CountriesController <LocationInfo::AdminController
  before_action :load_country, except: [:index, :new, :create]
  
  def index
    @countries = LocationInfo::Country.all.order(:name)
  end   
  
  def new
    @country = LocationInfo::Country.new
  end
  
  def edit
    @distributor_country = DistributorInfo::DistributorCountry.new(location_info_country_id: @country.id)
    @distributor_countries = DistributorInfo::DistributorCountry.where(location_info_country_id: @country.id)   
    
    @location_supported_country = LocationInfo::LocationSupportedCountry.new(location_info_country_id: @country.id)
    @location_supported_countries = LocationInfo::LocationSupportedCountry.where(location_info_country_id: @country.id)    

    @territory_supported_country = ContactInfo::TerritorySupportedCountry.new(location_info_country_id: @country.id)
    @territory_supported_countries = ContactInfo::TerritorySupportedCountry.where(location_info_country_id: @country.id)    
  end
  
  def create
    @country = LocationInfo::Country.new(country_params)
    if @country.save
      add_log(user: current_user, action: "Created country #{@country.harman_name}")
      redirect_to location_info_admin_countries_path, notice: "The country #{@country.harman_name} was created successfully."
    else
      render action: :new
    end
  end
  
  def update
    if @country.update(country_params)
      add_log(user: current_user, action: "Updated country #{@country.harman_name}")
      redirect_to location_info_admin_countries_path
    else
      render action: :edit
    end    
  end  
  
  def destroy
    if @country.destroy
      add_log(user: current_user, action: "Deleted country #{@country.harman_name}")
      redirect_to location_info_admin_countries_path
    end    
  end  
  
  def load_country
    @country = LocationInfo::Country.find(params[:id])
  end  
  
  def country_params
    params.require(:location_info_country).permit(:name, :harman_name, :alpha2, :alpha3, :continent, :region, :sub_region, :world_region, :harman_world_region, :calling_code, :numeric_code)
  end    
  
end  #  class LocationInfo::Admin::CountriesController <LocationInfo::AdminController
