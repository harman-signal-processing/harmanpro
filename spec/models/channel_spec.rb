require 'rails_helper'

RSpec.describe Channel, type: :model do

  before :all do
    @channel = FactoryBot.create(:channel)
  end

  subject { @channel }
  it { should respond_to(:name) }
  it { should respond_to(:channel_country_managers) }
end
