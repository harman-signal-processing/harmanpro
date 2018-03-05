class Tse::Admin::TseTechnologiesController < Tse::AdminController
  before_action :load_technology, except: [:index, :new, :create]

  def index
    @tse_technologies = TseTechnology.all
  end

  def show
  end

  def new
    @tse_technology = TseTechnology.new
  end

  def edit
  end

  def create
    @tse_technology = TseTechnology.new(tse_technology_params)
    if @tse_technology.save
      redirect_to tse_admin_tse_technologies_path, notice: "The technology was created successfully."
    else
      render action: :new
    end
  end

  def update
    if @tse_technology.update_attributes(tse_technology_params)
      redirect_to tse_admin_tse_technologies_path
    else
      render action: :edit
    end
  end

  def destroy
    if @tse_technology.destroy
      redirect_to tse_admin_tse_technologies_path
    end
  end

  private

  def load_technology
    @tse_technology = TseTechnology.find(params[:id])
    #authorize @tse_technology
  end

  def tse_technology_params
    params.require(:tse_technology).permit(:name)
  end
end

