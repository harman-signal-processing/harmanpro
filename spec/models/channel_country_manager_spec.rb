require 'rails_helper'

RSpec.describe ChannelCountryManager, type: :model do

  before :all do
    @ccm = FactoryBot.build(:channel_country_manager)
  end

  subject { @ccm }
  it { should respond_to(:channel) }
  it { should respond_to(:channel_country) }
  it { should respond_to(:channel_manager) }

end
