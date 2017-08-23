class Emea::ChannelManagersController < EmeaController
  respond_to :json

  def search
    channel = Channel.find(params[:channel_id])
    channel_country = ChannelCountry.find(params[:channel_country_id])

    channel_country_managers = channel.channel_country_managers.
      where(channel_country: channel_country).pluck(:channel_manager_id)

    respond_with ChannelManager.where(id: channel_country_managers)
  end
end
