class Tse::TseTechnologiesController < TseController
  respond_to :json

  def index
    @technologies = TseTechnology.all
    respond_with @technologies
  end

  def show
    respond_with TseTechnology.find(params[:id])
  end

end

