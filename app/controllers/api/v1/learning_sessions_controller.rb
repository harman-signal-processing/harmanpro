module Api
  module V1
    class LearningSessionsController < ApplicationController
      respond_to :json, :html
      layout "minimal"

      def show
        brand_param = params[:brand]
        brand = Brand.find_by_name(brand_param)

        respond_to do |format|
          if brand.present?
            @learning_session_events = brand.learning_sessions.order(created_at: :desc)
            @learning_session_page_overview = brand.learning_session_pages.first
            @learning_session_featured_videos = brand.learning_session_featured_videos.order(position: :asc)
            @learning_sessions = {
              page_content: @learning_session_page_overview,
              events: events_and_sessions(@learning_session_events),
              featured_videos: @learning_session_featured_videos}
            format.html
            format.json { respond_with @learning_sessions }
          else
            format.html { render plain: "Not found" }
            format.json { render :json => {"learning_sessions":[]} }
          end
        end  #  respond_to do |format|
      end  #  def show

      private

      def events_and_sessions(events)
        events_and_their_sessions = []
        events.each do |item|
          item[:sessions] = item.learning_session_event_sessions
          events_and_their_sessions << item
        end
        events_and_their_sessions
      end  #  def events_and_sessions(events)

    end  #  class LearningSessionsController < ApplicationController
  end  #  module V1
end  #  module Api
