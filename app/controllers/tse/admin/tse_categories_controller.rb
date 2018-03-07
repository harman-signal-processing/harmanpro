class Tse::Admin::TseCategoriesController < Tse::AdminController
  before_action :load_category, except: [:index, :new, :create]

  def index
    @tse_categories = TseCategory.all
  end

  def show
  end

  def new
    @tse_category = TseCategory.new
  end

  def edit
  end

  def create
    @tse_category = TseCategory.new(tse_category_params)
    if @tse_category.save
      redirect_to tse_admin_tse_categories_path, notice: "The category was created successfully."
    else
      render action: :new
    end
  end

  def update
    if @tse_category.update_attributes(tse_category_params)
      redirect_to tse_admin_tse_categories_path
    else
      render action: :edit
    end
  end

  def destroy
    if @tse_category.destroy
      redirect_to tse_admin_tse_categories_path
    end
  end

  private

  def load_category
    @tse_category = TseCategory.find(params[:id])
    #authorize @tse_category
  end

  def tse_category_params
    params.require(:tse_category).permit(:name, :parent_id, :notes)
  end
end

