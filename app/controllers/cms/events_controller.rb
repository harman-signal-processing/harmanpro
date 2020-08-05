class Cms::EventsController < CmsController
  before_action :set_locale_for_translator

  def index
    @events = Event.all
    if @available_locale
      render template: 'cms/available_locales/events/index' and return false
    end
  end

  def local
    if @available_locale
      @events = @available_locale.events.with_translations(@available_locale.key)
      render template: 'cms/available_locales/events/local' and return false
    end
  end

  def new
    @event = Event.new
    if @available_locale
      render template: 'cms/available_locales/events/new' and return false
    end
  end

  def create
    @event = Event.new(event_params)
    redirect_action = :index
    if @available_locale
      @event.original_locale = @available_locale
      redirect_action =  :local
    end
    if @event.save
      redirect_to action: redirect_action, notice: "Event was created"
    else
      render template: (@available_locale) ? 'cms/available_locales/events/new' : 'cms/events/new'
    end
  end

  def show
    @event = Event.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/events/edit' and return false
    end
  end

  def edit
    @event = Event.find(params[:id])
    if @available_locale
      if @event.original_locale && @event.original_locale == @available_locale
        render template: 'cms/available_locales/events/edit_local' and return false
      else
        render template: 'cms/available_locales/events/edit' and return false
      end
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      if @available_locale
        if @event.original_locale && @event.original_locale == @available_locale
          redirect_to [:local, :cms, @available_locale, @event.class], notice: 'Update successful'
        else
          redirect_to [:cms, @available_locale, @event.class], notice: 'Update successful'
        end
      end
    else
      if @available_locale
        if @event.original_locale && @event.original_locale == @available_locale
          render template: 'cms/available_locales/events/edit_local'
        else
          render template: 'cms/available_locales/events/edit'
        end
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @available_locale
      if @event.original_locale == @available_locale
        @event.destroy
        redirect_to [:local, :cms, @available_locale, @event.class], notice: "Event was deleted."
      else
        redirect_to [:local, :cms, @available_locale, @event.class], alert: "Cannot delete event not originated for #{@available_locale.name}."
      end
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name,
      :description,
      :start_on,
      :end_on,
      :image,
      :delete_image,
      :active,
      :featured,
      :more_info_link,
      :new_window,
      :page_content
    )
  end
end
