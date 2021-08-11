require 'rails_helper'

RSpec.describe Artist, type: :model do

  before :all do
    @artist = FactoryBot.build(:artist)
  end

  subject { @artist }
  it { should respond_to :name }
  it { should respond_to :photo }
  it { should respond_to :overview }
  it { should respond_to :description }
  it { should respond_to :friendly_id }
  it { should respond_to :locale }

  it "locale should be an AvailableLocale" do
    expect(@artist.locale).to be_an(AvailableLocale)
  end
end
