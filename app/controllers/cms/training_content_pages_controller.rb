class Cms::TrainingContentPagesController < CmsController
  before_action :set_locale_for_translator

  def index
    @training_content_pages = TrainingContentPage.where(original_locale_id: [nil, AvailableLocale.default_id])
    if @available_locale
      render template: 'cms/available_locales/training_content_pages/index' and return false
    end
  end

  def originated
    if @available_locale
      @training_content_pages = @available_locale.training_content_pages.with_translations
      render template: 'cms/available_locales/training_content_pages/originated' and return false
    end
  end

  def new
    @training_content_page = TrainingContentPage.new
    if @available_locale
      render template: 'cms/available_locales/training_content_pages/new' and return false
    end
  end

  def create
    @training_content_page = TrainingContentPage.new(training_content_page_params)
    redirect_action = :index
    if @available_locale
      @training_content_page.original_locale = @available_locale
      redirect_action =  :originated
    end
    if @training_content_page.save
      redirect_to action: redirect_action, notice: "Page was created"
    else
      render template: (@available_locale) ? 'cms/available_locales/training_content_pages/new' : 'cms/training_content_pages/new'
    end
  end

  def show
    @training_content_page = TrainingContentPage.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/training_content_pages/edit' and return false
    end
  end

  def edit
    @training_content_page = TrainingContentPage.find(params[:id])
    if @available_locale
      if @training_content_page.original_locale && @training_content_page.original_locale == @available_locale
        render template: 'cms/available_locales/training_content_pages/edit_originated' and return false
      else
        render template: 'cms/available_locales/training_content_pages/edit' and return false
      end
    end
  end

  def update
    @training_content_page = TrainingContentPage.find(params[:id])
    if @training_content_page.update_attributes(training_content_page_params)
      if @available_locale
        if @training_content_page.original_locale && @training_content_page.original_locale == @available_locale
          redirect_to [:originated, :cms, @available_locale, @training_content_page.class], notice: 'Update successful'
        else
          redirect_to [:cms, @available_locale, @training_content_page.class], notice: 'Update successful'
        end
      end
    else
      if @available_locale
        if @training_content_page.original_locale && @training_content_page.original_locale == @available_locale
          render template: 'cms/available_locales/training_content_pages/edit_originated'
        else
          render template: 'cms/available_locales/training_content_pages/edit'
        end
      end
    end
  end

  def destroy
    @training_content_page = TrainingContentPage.find(params[:id])
    if @available_locale
      if @training_content_page.original_locale == @available_locale
        @training_content_page.destroy
        redirect_to [:originated, :cms, @available_locale, @training_content_page.class], notice: "Page was deleted."
      else
        redirect_to [:originated, :cms, @available_locale, @training_content_page.class], alert: "Cannot delete page not originated for #{@available_locale.name}."
      end
    end
  end

  private

  def training_content_page_params
    params.require(:training_content_page).permit(
      :title, :subtitle, :main_content, :right_content, :sub_content, :description,
      :banner, :delete_banner, :hide_title
    )
  end    
end
