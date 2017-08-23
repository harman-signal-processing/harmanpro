class Emea::Admin::ChannelCountriesController < Emea::AdminController

  def index
    if params[:id].present?
      redirect_to emea_admin_channel_country_path(params[:id])
    else
      redirect_to emea_admin_channel_country_managers_path
    end
  end

  def show
    @channel_country = ChannelCountry.find(params[:id])
    @channel_country_manager = ChannelCountryManager.new(channel_country: @channel_country, created_from: "channel_country")
  end

  def new
    @channel_country = ChannelCountry.new
  end

  def edit
    @channel_country = ChannelCountry.find(params[:id])
  end

  def create
    @channel_country = ChannelCountry.new(channel_country_params)
    if @channel_country.save
      redirect_to [:emea, :admin, @channel_country], notice: "Now you can add channels and managers to the new country."
    else
      render action: :new
    end
  end

  def update
    @channel_country = ChannelCountry.find(params[:id])
    if @channel_country.update_attributes(channel_country_params)
      redirect_to [:emea, :admin, @channel_country]
    else
      render action: :edit
    end
  end

  def destroy
    @channel_country = ChannelCountry.find(params[:id])
    if @channel_country.destroy
      redirect_to emea_admin_channel_country_managers_path
    end
  end

  private

  def channel_country_params
    params.require(:channel_country).permit(:name)
  end
end
