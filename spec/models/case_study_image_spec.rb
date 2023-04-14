require 'rails_helper'

RSpec.describe CaseStudyImage, type: :model do

  before :all do
    @case_study_image = build(:case_study_image)
  end

  subject { @case_study_image }
  it { should respond_to(:case_study) }
  it { should respond_to(:position) }
  it { should respond_to(:image) }

end
