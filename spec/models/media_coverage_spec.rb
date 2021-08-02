require 'rails_helper'

RSpec.describe MediaCoverage, type: :model do

  before :each do
    @media_coverage = build(:media_coverage)
  end


  subject { @media_coverage }
  it { should respond_to(:media_outlet) }
  it { should respond_to(:brands) }
end
