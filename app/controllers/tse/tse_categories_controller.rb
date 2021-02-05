class Tse::TseCategoriesController < TseController

  def index
    @cats = TseCategory.all
    if params[:parent_id]
      @cats = @cats.where(parent_id: params[:parent_id]).order(:position)
    else
      @cats = TseCategory.ordered_parents
    end
    respond_to do |format|
      format.json { render json: { "tse_categories" => @cats } }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: TseCategory.find(params[:id]) }
    end
  end

end

