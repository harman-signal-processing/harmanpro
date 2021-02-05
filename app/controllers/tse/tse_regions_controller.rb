class Tse::TseRegionsController < TseController
  respond_to :json

  def index
    @regions = TseRegion.all
    if params[:parent] == "true"
      @regions = @regions.where(parent_id: nil).order(:name)
    end

    respond_to do |format|
      format.json { render json: { "tse_regions" => @regions } }
    end
  end

  def show
    respond_with TseRegion.find(params[:id])
  end

end



