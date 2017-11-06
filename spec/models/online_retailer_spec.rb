require 'rails_helper'

RSpec.describe OnlineRetailer, type: :model do

  before(:all) do
    @online_retailer = FactoryBot.create(:online_retailer)
  end

  subject { @online_retailer }
  it { should respond_to :friendly_id }
  it { should respond_to :logo }
  it { should respond_to :url }

  it "should not allow invalid URLs" do
    @online_retailer.url = "a-non valid url"

    expect(@online_retailer.valid?).to be(false)
  end

end
