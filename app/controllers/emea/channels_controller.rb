class Emea::ChannelsController < EmeaController
  respond_to :json

  def index
    respond_with Channel.all
  end

end
