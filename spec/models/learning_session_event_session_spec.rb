require 'rails_helper'

RSpec.describe LearningSessionEventSession, type: :model do
  before :all do
    @learning_session_event_session = FactoryBot.build(:learning_session_event_session)
  end

  subject { @learning_session_event_session }
  it { should respond_to :title }
  it { should respond_to :session_date }
  it { should respond_to :session_times }
  it { should respond_to :register_link }
  it { should respond_to :learning_session_event }

end  #  RSpec.describe LearningSessionEventSession, type: :model do
