require 'rails_helper'

RSpec.describe MediaOutlet, type: :model do

  before :each do
    @media_outlet = build(:media_outlet)
  end


  subject { @media_outlet }
  it { should respond_to(:media_coverages) }
end
