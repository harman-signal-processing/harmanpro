require 'rails_helper'

class GoAcousticStub
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
  it { should respond_to(:country) }

  describe "marketing automation" do
    it "sends to acoustic list" do
      lead = FactoryBot.build(:lead)
      expect(Lead).to receive(:goacoustic_client).and_return(GoAcousticStub.new)
      expect_any_instance_of(GoAcousticStub).to receive(:add_recipient).and_return(true)

      lead.save
    end
  end

  describe "emailing" do
    it "sends contact info to several configured recipients" do
      expect(Lead).to receive(:goacoustic_client).and_return(GoAcousticStub.new)
      expect_any_instance_of(GoAcousticStub).to receive(:add_recipient).and_return(true)

      lead = FactoryBot.create(:lead)
      expect(lead).to receive(:notify_leadgen_recipients)

      lead.update(recipient_id: "12345")
    end
  end
end
