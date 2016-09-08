require 'rails_helper'

RSpec.describe Slide, type: :model do

  before :all do
    @slide = FactoryGirl.create(:slide)
  end

  subject { @slide }
  it { should respond_to(:name) }
  it { should respond_to(:background) }
  it { should respond_to(:locale) }

  it "locale should be an AvailableLocale" do
    expect(@slide.locale).to be_an AvailableLocale
  end
end
