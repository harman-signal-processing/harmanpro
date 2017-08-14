class EmeaController < ApplicationController
  before_action :authenticate_user!

  def index
    @page = EmeaPage.home
    render template: 'emea/emea_pages/show'
  end
end
