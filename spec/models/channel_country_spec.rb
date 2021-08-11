require 'rails_helper'

RSpec.describe ChannelCountry, type: :model do

  before :all do
    @channel_country = FactoryBot.build(:channel_country)
  end

  subject { @channel_country }
  it { should respond_to(:name) }
  it { should respond_to(:channel_country_managers) }
end
