class Tse::TseCategoriesController < TseController
  respond_to :json

  def index
    @cats = TseCategory.all
    if params[:parent_id]
      @cats = @cats.where(parent_id: params[:parent_id])
    else
      @cats = @cats.where(parent_id: nil)
    end
    respond_with @cats
  end

  def show
    respond_with TseCategory.find(params[:id])
  end

end

