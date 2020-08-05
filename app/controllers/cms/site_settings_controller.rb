class Cms::SiteSettingsController < CmsController
  before_action :set_locale_for_translator

  def index
    @site_settings = SiteSetting.all
    if @available_locale
      render template: 'cms/available_locales/site_settings/index' and return false
    end
  end

  def show
    @site_setting = SiteSetting.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/site_settings/edit' and return false
    end
  end

  def edit
    @site_setting = SiteSetting.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/site_settings/edit' and return false
    end
  end

  def update
    @site_setting = SiteSetting.find(params[:id])
    if @site_setting.update(site_setting_params)
      if @available_locale
        redirect_to [:cms, @available_locale, @site_setting.class], notice: 'Update successful'
      end
    else
      if @available_locale
        render template: 'cms/available_locales/site_settings/edit'
      end
    end
  end

  private

  def site_setting_params
    params.require(:site_setting).permit(
      :content
    )
  end
end
