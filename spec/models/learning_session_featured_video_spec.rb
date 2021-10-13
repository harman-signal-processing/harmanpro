require 'rails_helper'

RSpec.describe LearningSessionFeaturedVideo, type: :model do
  before :all do
    @learning_session_featured_video = FactoryBot.build(:learning_session_featured_video)
  end

  subject { @learning_session_featured_video }
  it { should respond_to :title }
  it { should respond_to :youtube_id }
  it { should respond_to :brand }
  it { should respond_to :position }
end  #  RSpec.describe LearningSessionFeaturedVideo, type: :model do
