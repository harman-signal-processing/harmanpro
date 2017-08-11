class EmeaPagesController < ApplicationController
  layout 'emea'

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
