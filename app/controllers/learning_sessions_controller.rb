class LearningSessionsController < ApplicationController

  def index
    prosite_id = Brand.where("name = 'harman professional solutions'").first.id
    @page_content = LearningSessionPage.where("brand_id = ?", prosite_id).first.body
    @events = LearningSessionEvent.joins(:learning_session_event_sessions)
      .where("learning_session_event_sessions.session_date >= ?", Date.today)
      .order("learning_session_event_sessions.session_date")
      .uniq

    @featured_videos = LearningSessionFeaturedVideo.where("brand_id = ?", prosite_id)

  end  #  def index

end  #  class LearningSessionsController < ApplicationController