class Tse::Admin::TseDomainsController < Tse::AdminController
  before_action :load_domain, except: [:index, :new, :create]

  def index
    @tse_domains = TseDomain.all
  end

  def show
  end

  def new
    @tse_domain = TseDomain.new
  end

  def edit
  end

  def create
    @tse_domain = TseDomain.new(tse_domain_params)
    if @tse_domain.save
      redirect_to tse_admin_tse_domains_path, notice: "The domain was created successfully."
    else
      render action: :new
    end
  end

  def update
    if @tse_domain.update(tse_domain_params)
      redirect_to tse_admin_tse_domains_path
    else
      render action: :edit
    end
  end

  def destroy
    if @tse_domain.destroy
      redirect_to tse_admin_tse_domains_path
    end
  end

  private

  def load_domain
    @tse_domain = TseDomain.find(params[:id])
    #authorize @tse_domain
  end

  def tse_domain_params
    params.require(:tse_domain).permit(:name)
  end
end

