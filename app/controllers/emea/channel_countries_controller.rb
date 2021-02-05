class Emea::ChannelCountriesController < EmeaController

  def index
    respond_to do |format|
      format.json { render json: { "channel_countries" => ChannelCountry.order(:name) } }
    end
  end

end
