class Cms::LandingPagesController < CmsController
  before_action :set_locale_for_translator

  def index
    @landing_pages = LandingPage.where(original_locale_id: [nil, AvailableLocale.default_id])
    if @available_locale
      render template: 'cms/available_locales/landing_pages/index' and return false
    end
  end

  def originated
    if @available_locale
      @landing_pages = @available_locale.landing_pages.with_translations(@available_locale.key)
      render template: 'cms/available_locales/landing_pages/originated' and return false
    end
  end

  def new
    @landing_page = LandingPage.new
    if @available_locale
      render template: 'cms/available_locales/landing_pages/new' and return false
    end
  end

  def create
    @landing_page = LandingPage.new(landing_page_params)
    redirect_action = :index
    if @available_locale
      @landing_page.original_locale = @available_locale
      redirect_action =  :originated
    end
    if @landing_page.save
      redirect_to action: redirect_action, notice: "Page was created"
    else
      render template: (@available_locale) ? 'cms/available_locales/landing_pages/new' : 'cms/landing_pages/new'
    end
  end

  def show
    @landing_page = LandingPage.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/landing_pages/edit' and return false
    end
  end

  def edit
    @landing_page = LandingPage.find(params[:id])
    if @available_locale
      if @landing_page.original_locale && @landing_page.original_locale == @available_locale
        render template: 'cms/available_locales/landing_pages/edit_originated' and return false
      else
        render template: 'cms/available_locales/landing_pages/edit' and return false
      end
    end
  end

  def update
    @landing_page = LandingPage.find(params[:id])
    if @landing_page.update(landing_page_params)
      if @available_locale
        if @landing_page.original_locale && @landing_page.original_locale == @available_locale
          redirect_to [:originated, :cms, @available_locale, @landing_page.class], notice: 'Update successful'
        else
          redirect_to [:cms, @available_locale, @landing_page.class], notice: 'Update successful'
        end
      end
    else
      if @available_locale
        if @landing_page.original_locale && @landing_page.original_locale == @available_locale
          render template: 'cms/available_locales/landing_pages/edit_originated'
        else
          render template: 'cms/available_locales/landing_pages/edit'
        end
      end
    end
  end

  def destroy
    @landing_page = LandingPage.find(params[:id])
    if @available_locale
      if @landing_page.original_locale == @available_locale
        @landing_page.destroy
        redirect_to [:originated, :cms, @available_locale, @landing_page.class], notice: "Page was deleted."
      else
        redirect_to [:originated, :cms, @available_locale, @landing_page.class], alert: "Cannot delete page not originated for #{@available_locale.name}."
      end
    end
  end

  private

  def landing_page_params
    params.require(:landing_page).permit(
      :title, :subtitle, :main_content, :left_content, :right_content, :sub_content, :description,
      :banner, :delete_banner, :hide_title
    )
  end
end
