class Emea::ChannelsController < EmeaController

  def index
    respond_to do |format|
      format.json { render json: {"channels" => Channel.all} }
    end
  end

end
