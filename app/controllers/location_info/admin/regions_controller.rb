class LocationInfo::Admin::RegionsController < LocationInfo::AdminController
  before_action :load_region, except: [:index, :new, :create]
  
  def index
    @regions = LocationInfo::Region.all
  end   
  
  def new
    @region = LocationInfo::Region.new
  end
  
  def edit
    @location_region = LocationInfo::LocationRegion.new(location_info_region_id: @region.id)
    @location_regions = LocationInfo::LocationRegion.where(location_info_region_id: @region.id)     
  end
  
  def create
    @region = LocationInfo::Region.new(region_params)
    if @region.save
      redirect_to location_info_admin_regions_path, notice: "The region #{@region.name} was created successfully."
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
    params.require(:location_info_region).permit(:name)
  end   
  
end  #  class LocationInfo::Admin::RegionsController < LocationInfo::AdminController
