class Tse::TseTechnologiesController < TseController
  respond_to :json

  def index
    respond_to do |format|
      format.json { render json: { "tse_technologies" => TseTechnology.order(:name) } }
    end
  end

  def show
    respond_with TseTechnology.find(params[:id])
  end

end

