class EmeaPagesController < EmeaController

  def index
    @page = EmeaPage.home
    authorize @page
    render action: :show
  end

  def show
    @page = EmeaPage.find(params[:id])
    authorize @page
  end
end
