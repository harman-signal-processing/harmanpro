class Cms::ReferenceSystemsController < CmsController
  before_action :set_locale_for_translator

  def index
    @reference_systems = ReferenceSystem.all
    if @available_locale
      render template: 'cms/available_locales/reference_systems/index' and return false
    end
  end

  def show
    @reference_system = ReferenceSystem.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/reference_systems/edit' and return false
    end
  end

  def edit
    @reference_system = ReferenceSystem.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/reference_systems/edit' and return false
    end
  end

  def update
    @reference_system = ReferenceSystem.find(params[:id])
    if @reference_system.update(reference_system_params)
      if @available_locale
        redirect_to [:cms, @available_locale, @reference_system.class], notice: 'Update successful'
      end
    else
      if @available_locale
        render template: 'cms/available_locales/reference_systems/edit'
      end
    end
  end

  private

  def reference_system_params
    params.require(:reference_system).permit(
      :name, :description, :headline, :venue_size_descriptor
    )
  end
end
