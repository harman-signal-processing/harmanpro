require 'rails_helper'

RSpec.describe CaseStudyVerticalMarket, type: :model do

  before :all do
    @case_study_vertical_market = FactoryBot.build(:case_study_vertical_market)
  end

  subject { @case_study_vertical_market }
  it { should respond_to(:case_study) }
  it { should respond_to(:vertical_market) }


end
