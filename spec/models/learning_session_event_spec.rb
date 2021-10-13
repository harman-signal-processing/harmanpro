require 'rails_helper'

RSpec.describe LearningSessionEvent, type: :model do
  before :all do
    @learning_session_event = FactoryBot.build(:learning_session_event)
  end
    
  subject { @learning_session_event }
  it { should respond_to :title }
  it { should respond_to :subtitle }
  it { should respond_to :description }
  
end  #  RSpec.describe LearningSessionEvent, type: :model do
