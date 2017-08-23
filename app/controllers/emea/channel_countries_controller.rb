class Emea::ChannelCountriesController < EmeaController
  respond_to :json

  def index
    respond_with ChannelCountry.order(:name)
  end

end
