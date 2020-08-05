class Cms::SlidesController < CmsController
  before_action :set_locale_for_translator

  def index
    if @available_locale
      @slides = @available_locale.slides
      render template: 'cms/available_locales/slides/index' and return false
    end
  end

  def new
    @slide = Slide.new
    render template: 'cms/available_locales/slides/new' and return false
  end

  def create
    @slide = Slide.new(slide_params)
    @slide.locale = @available_locale

    if @slide.save
      redirect_to [:cms, @available_locale, @slide.class], notice: "Slide was created"
    else
      render template: 'cms/available_locales/slides/new'
    end
  end

  def show
    @slide = Slide.find(params[:id])
    render template: 'cms/available_locales/slides/edit' and return false
  end

  def edit
    @slide = Slide.find(params[:id])
    render template: 'cms/available_locales/slides/edit' and return false
  end

  def update
    @slide = Slide.find(params[:id])
    if @slide.update(slide_params)
      redirect_to [:cms, @available_locale, @slide.class], notice: 'Update successful'
    else
      render template: 'cms/available_locales/slides/edit'
    end
  end

  def destroy
    @slide = Slide.find(params[:id])
    @slide.destroy
    redirect_to [:cms, @available_locale, @slide.class], notice: "Slide was deleted."
  end

  private

  def slide_params
    params.require(:slide).permit(
      :name,
      :position,
      :start_on,
      :end_on,
      :background,
      :bubble,
      :headline,
      :description,
      :link_text,
      :link_url,
      :link_new_window,
      :delete_background
    )
  end
end
