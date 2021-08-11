require 'rails_helper'

RSpec.describe ChannelManager, type: :model do

  before :all do
    @channel_manager = FactoryBot.build(:channel_manager)
  end

  subject { @channel_manager }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:telephone) }
  it { should respond_to(:channel_country_managers) }
end
