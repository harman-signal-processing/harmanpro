class Emea::Admin::ChannelCountryManagersController < Emea::AdminController
  def index
    @channels = Channel.order(:name)
    @channel_countries = ChannelCountry.order(:name)
    @channel_managers = ChannelManager.order(:name)
    @channel = Channel.new
    @channel_country = ChannelCountry.new
    @channel_manager = ChannelManager.new
  end

  def new
    @channel_country_manager = ChannelCountryManager.new
  end

  def edit
    @channel_country_manager = ChannelCountryManager.find(params[:id])
  end

  def create
    @channel_country_manager = ChannelCountryManager.new(channel_country_manager_params)
    if @channel_country_manager.save
      if @channel_country_manager.created_from.present?
        redirect_to [:emea, :admin, @channel_country_manager.send(@channel_country_manager.created_from)]
      else
        redirect_to emea_admin_channel_country_managers_path, notice: "Channel/Country/Manager created successfully."
      end
    else
      render action: "new"
    end
  end

  def update
    @channel_country_manager = ChannelCountryManager.find(params[:id])
    if @channel_country_manager.update(channel_country_manager_params)
      if @channel_country_manager.created_from.present?
        redirect_to [:emea, :admin, @channel_country_manager.send(@channel_country_manager.created_from)]
      else
        redirect_to emea_admin_channel_country_managers_path, notice: "Channel/Country/Manager updated successfully."
      end
    else
      render action: "edit"
    end
  end

  def destroy
    @channel_country_manager = ChannelCountryManager.find(params[:id])
    @channel_country_manager.destroy
    if @channel_country_manager.created_from.present?
      redirect_to [:emea, :admin, @channel_country_manager.send(@channel_country_manager.created_from)]
    else
      redirect_to emea_admin_channel_country_managers_path, notice: "Channel/Country/Manager association deleted successfully."
    end
  end

  private

  def channel_country_manager_params
    params.require(:channel_country_manager).permit(:channel_id, :channel_manager_id, :channel_country_id)
  end
end
