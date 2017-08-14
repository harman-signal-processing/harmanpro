class CmsController < ApplicationController
  before_action :authenticate_cms_user!
  layout 'cms'

  def index
  end

  private

  def set_locale_for_translator
    if params[:available_locale_id]
      @available_locale = AvailableLocale.find(params[:available_locale_id])
      I18n.locale = @available_locale.key.to_sym
    else
      @available_locale ||= false
    end
  end
end
