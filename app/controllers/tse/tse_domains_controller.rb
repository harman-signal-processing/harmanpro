class Tse::TseDomainsController < TseController
  respond_to :json

  def index
    respond_to do |format|
      format.json { render json: { "tse_domains" => TseDomain.all } }
    end
  end

  def show
    respond_with TseDomain.find(params[:id])
  end

end


