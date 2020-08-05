class Tse::Admin::TseRegionsController < Tse::AdminController
  before_action :load_region, except: [:index, :new, :create]

  def index
    @tse_regions = TseRegion.all
  end

  def show
  end

  def new
    @tse_region = TseRegion.new
  end

  def edit
  end

  def create
    @tse_region = TseRegion.new(tse_region_params)
    if @tse_region.save
      redirect_to tse_admin_tse_regions_path, notice: "The region was created successfully."
    else
      render action: :new
    end
  end

  def update
    if @tse_region.update(tse_region_params)
      redirect_to tse_admin_tse_regions_path
    else
      render action: :edit
    end
  end

  def destroy
    if @tse_region.destroy
      redirect_to tse_admin_tse_regions_path
    end
  end

  private

  def load_region
    @tse_region = TseRegion.find(params[:id])
    #authorize @tse_region
  end

  def tse_region_params
    params.require(:tse_region).permit(:name, :parent_id)
  end
end

