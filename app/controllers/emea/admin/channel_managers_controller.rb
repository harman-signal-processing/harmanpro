class Emea::Admin::ChannelManagersController < Emea::AdminController

  def index
    if params[:id].present?
      redirect_to emea_admin_channel_manager_path(params[:id])
    else
      redirect_to emea_admin_channel_country_managers_path
    end
  end

  def show
    @channel_manager = ChannelManager.find(params[:id])
    @channel_country_manager = ChannelCountryManager.new(channel_manager: @channel_manager, created_from: "channel_manager")
  end

  def new
    @channel_manager = ChannelManager.new
  end

  def edit
    @channel_manager = ChannelManager.find(params[:id])
  end

  def create
    @channel_manager = ChannelManager.new(channel_manager_params)
    if @channel_manager.save
      redirect_to [:emea, :admin, @channel_manager], notice: "Now you can add countries and channels to the new manager."
    else
      render action: :new
    end
  end

  def update
    @channel_manager = ChannelManager.find(params[:id])
    if @channel_manager.update(channel_manager_params)
      redirect_to [:emea, :admin, @channel_manager]
    else
      render action: :edit
    end
  end

  def destroy
    @channel_manager = ChannelManager.find(params[:id])
    if @channel_manager.destroy
      redirect_to emea_admin_channel_country_managers_path
    end
  end

  private

  def channel_manager_params
    params.require(:channel_manager).permit(:name, :email, :telephone)
  end
end
