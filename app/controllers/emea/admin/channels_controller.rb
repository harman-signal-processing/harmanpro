class Emea::Admin::ChannelsController < Emea::AdminController

  def index
    if params[:id].present?
      redirect_to emea_admin_channel_path(params[:id])
    else
      redirect_to emea_admin_channel_country_managers_path
    end
  end

  def show
    @channel = Channel.find(params[:id])
    @channel_country_manager = ChannelCountryManager.new(channel: @channel, created_from: "channel")
  end

  def new
    @channel = Channel.new
  end

  def edit
    @channel = Channel.find(params[:id])
  end

  def create
    @channel = Channel.new(channel_params)
    if @channel.save
      redirect_to [:emea, :admin, @channel], notice: "Now you can add countries and managers to the new channel."
    else
      render action: :new
    end
  end

  def update
    @channel = Channel.find(params[:id])
    if @channel.update_attributes(channel_params)
      redirect_to [:emea, :admin, @channel]
    else
      render action: :edit
    end
  end

  def destroy
    @channel = Channel.find(params[:id])
    if @channel.destroy
      redirect_to emea_admin_channel_country_managers_path
    end
  end

  private

  def channel_params
    params.require(:channel).permit(:name)
  end
end
