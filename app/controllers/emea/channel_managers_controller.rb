class Emea::ChannelManagersController < EmeaController

  def search
    channel = Channel.find(params[:channel_id])
    channel_country = ChannelCountry.find(params[:channel_country_id])

    channel_country_managers = channel.channel_country_managers.
      where(channel_country: channel_country).pluck(:channel_manager_id)

    respond_to do |format|
      format.json { render json: { "channel_managers" => ChannelManager.where(id: channel_country_managers) } }
    end
  end
end
