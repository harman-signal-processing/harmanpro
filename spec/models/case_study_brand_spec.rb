require 'rails_helper'

RSpec.describe CaseStudyBrand, type: :model do

  before :all do
    @case_study_brand = FactoryBot.build(:case_study_brand)
  end

  subject { @case_study_brand }
  it { should respond_to(:case_study) }
  it { should respond_to(:brand) }


end  #  RSpec.describe CaseStudyBrand, type: :model do
