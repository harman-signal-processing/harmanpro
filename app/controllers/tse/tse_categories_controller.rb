class Tse::TseCategoriesController < TseController
  respond_to :json

  def index
    @cats = TseCategory.all
    if params[:parent_id]
      @cats = @cats.where(parent_id: params[:parent_id]).order(:position)
    else
      @cats = TseCategory.ordered_parents
    end
    respond_with @cats
  end

  def show
    respond_with TseCategory.find(params[:id])
  end

end

