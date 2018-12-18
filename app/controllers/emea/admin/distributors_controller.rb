class Emea::Admin::DistributorsController < Emea::AdminController
  before_action :load_distributor, except: [:index, :new, :create]

  def index
    respond_to do |format|
      format.html {
        @distributors = Distributor.where(region: "EMEA").order(Arel.sql("name"))
        @q ||= @distributors.ransack(params[:q])
        if params[:q]
          @distributors = @q.result(:distinct => true)
        end
      }
    end
  end

  def new
    @distributor = Distributor.new(region: "EMEA")
  end

  def show
  end

  def edit
  end

  def create
    @distributor = Distributor.new(distributor_params)
    if @distributor.save
      redirect_to [:emea, :admin, @distributor], notice: "The new distributor was created successfully."
    else
      render action: :new
    end
  end

  def update
    @distributor = Distributor.find(params[:id])
    if @distributor.update_attributes(distributor_params)
      redirect_to [:emea, :admin, @distributor], notice: "Update complete."
    else
      render action: :edit
    end
  end

  def destroy
    if @distributor.destroy
      redirect_to action: 'index', notice: "Distributor was deleted successfully."
    else
      redirect_to [:emea, :admin, @distributor], alert: "Distributor could not be deleted."
    end
  end

  private

  def distributor_params
    params.require(:distributor).permit(:name,
      :country,
      :channel_manager,
      :contact_name,
      :contact_phone,
      :contact_email,
      :time_zone,
      :details_public,
      :details_private,
      :region,
      :website,
      brand_ids: []
    )
  end

  def load_distributor
    @distributor = Distributor.find(params[:id])
    authorize @distributor
  end

end

