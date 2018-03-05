class Tse::TseRegionsController < TseController
  respond_to :json

  def index
    @regions = TseRegion.all
    respond_with @regions
  end

  def show
    respond_with TseRegion.find(params[:id])
  end

end



