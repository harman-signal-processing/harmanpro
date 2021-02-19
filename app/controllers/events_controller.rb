class EventsController < ApplicationController

  def index
    all_events = Event.current_and_upcoming.
      where("start_on < ?", 6.months.from_now)
    @events = filter_by_locale(all_events)
    if @events.length == 0
      redirect_to learning_sessions_path and return false
    end
    @banner_image = Resource.find_by(name:"Banner: Events")
  end

  def show
    @event = Event.find(params[:id])
    unless @event.active?
      redirect_to events_path and return false
    end
  end

  def recent
    @events = filter_by_locale(Event.recent)
  end

  private

  # Removes events which don't belong to the current locale.
  # We're including events from the site's default locale on
  # all other locales.
  #
  def filter_by_locale(events)
    included_locales = [nil, '', AvailableLocale.default_id]
    if AvailableLocale.exists?(key: I18n.locale)
      included_locales << AvailableLocale.find_by(key: I18n.locale).id
    end
    events.where(original_locale_id: included_locales)
  end

end
