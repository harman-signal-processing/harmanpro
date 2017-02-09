require 'rails_helper'

class SilverPopStub
  def add_recipient(user, db, list)
    true
  end
end

RSpec.describe Lead, :type => :model do
  before :all do
    @lead = FactoryGirl.build(:lead)
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
    it "sends to silverpop list" do
      lead = FactoryGirl.build(:lead)
      expect(lead).to receive(:silverpop_client).and_return(SilverPopStub.new)
      expect_any_instance_of(SilverPopStub).to receive(:add_recipient).and_return(true)

      lead.save
    end
  end

  describe "emailing" do
    it "sends contact info to several configured recipients" do
      lead = FactoryGirl.build(:lead)
      expect(lead).to receive(:notify_leadgen_recipients)
      expect(lead).to receive(:silverpop_client).and_return(SilverPopStub.new)
      expect_any_instance_of(SilverPopStub).to receive(:add_recipient).and_return(true)

      lead.save
    end
  end
end
