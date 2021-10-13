require 'rails_helper'

RSpec.describe LearningSessionPage, type: :model do
  before :all do
    @learning_session_page = FactoryBot.build(:learning_session_page)
  end

  subject { @learning_session_page }
  it { should respond_to :body }
  it { should respond_to :custom_css }
  it { should respond_to :brand }
end  #  RSpec.describe LearningSessionPage, type: :model do
