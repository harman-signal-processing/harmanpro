class Tse::TseDomainsController < TseController
  respond_to :json

  def index
    @domains = TseDomain.all
    respond_with @domains
  end

  def show
    respond_with TseDomain.find(params[:id])
  end

end


