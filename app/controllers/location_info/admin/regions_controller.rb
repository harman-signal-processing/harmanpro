class LocationInfo::Admin::RegionsController < LocationInfo::AdminController
  before_action :load_region, except: [:index, :new, :create]
  
  def index
    @regions = LocationInfo::Region.all
  end   
  
  def new
    @region = LocationInfo::Region.new
    # binding.pry
    location_id = params[:region][:location_id] unless params[:region].nil?
    @location = LocationInfo::Location.find(location_id) if location_id.present?    
    
  end
  
  def edit
    @location_region = LocationInfo::LocationRegion.new(location_info_region_id: @region.id)
    @location_regions = LocationInfo::LocationRegion.where(location_info_region_id: @region.id)    
  end
  
  def create
    @region = LocationInfo::Region.new(region_params.except(:location_id))
    @location = region_params[:location_id].present? ? LocationInfo::Location.find(region_params[:location_id]) : nil
    
    if @region.save
      if @location.present?
        @region.locations << @location
        redirect_to edit_location_info_admin_location_path(@location), notice: "The region #{@region.name} was created successfully and associated to #{@location.name}."      
      else
        redirect_to location_info_admin_regions_path, notice: "The region #{@region.name} was created successfully."
      end
    else
      render action: :new
    end
  end
  
  def update
    if @region.update_attributes(region_params)
      redirect_to location_info_admin_regions_path
    else
      render action: :edit
    end    
  end
  
  def destroy
    if @region.destroy
      redirect_to location_info_admin_regions_path
    end    
  end  
  
  def load_region
    @region = LocationInfo::Region.find(params[:id])
  end  
  
  def region_params
    params.require(:location_info_region).permit(:name, :location_id)
  end   
  
end  #  class LocationInfo::Admin::RegionsController < LocationInfo::AdminController
