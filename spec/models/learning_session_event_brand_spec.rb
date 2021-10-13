require 'rails_helper'

RSpec.describe LearningSessionEventBrand, type: :model do
  before :all do
    @learning_session_event_brand = FactoryBot.build(:learning_session_event_brand)
  end

  subject { @learning_session_event_brand }
  it { should respond_to :learning_session_event }
  it { should respond_to :brand }

end  #  RSpec.describe LearningSessionEventBrand, type: :model do
