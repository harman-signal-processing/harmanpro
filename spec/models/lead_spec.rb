require 'rails_helper'

class AcousticStub
  def add_recipient(user, db, list)
    true
  end
end

RSpec.describe Lead, :type => :model do
  before :all do
    @lead = FactoryBot.build(:lead)
  end

  subject { @lead }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:company) }
  it { should respond_to(:phone) }
  it { should respond_to(:project_description) }
  it { should respond_to(:source) }
  it { should respond_to(:location) }

  describe "marketing automation" do
    it "sends to acoustic list" do
      lead = FactoryBot.build(:lead)
      expect(lead).to receive(:acoustic_client).and_return(AcousticStub.new)
      expect_any_instance_of(AcousticStub).to receive(:add_recipient).and_return(true)

      lead.save
    end
  end

  describe "emailing" do
    it "sends contact info to several configured recipients" do
      lead = FactoryBot.build(:lead)
      expect(lead).to receive(:notify_leadgen_recipients)
      expect(lead).to receive(:acoustic_client).and_return(AcousticStub.new)
      expect_any_instance_of(AcousticStub).to receive(:add_recipient).and_return(true)

      lead.save
    end
  end
end
