require 'rails_helper'

class CrmClientStub
  def add_lead(lead)
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
      expect(Lead).to receive(:crm_client).and_return(CrmClientStub.new)
      expect_any_instance_of(CrmClientStub).to receive(:add_lead).and_return(true)

      lead.save
    end
  end

  describe "emailing" do
    it "sends contact info to several configured recipients" do
      expect(Lead).to receive(:crm_client).and_return(CrmClientStub.new)
      expect_any_instance_of(CrmClientStub).to receive(:add_lead).and_return(true)

      lead = FactoryBot.create(:lead)
      expect(lead).to receive(:notify_leadgen_recipients)

      lead.update(recipient_id: "12345")
    end
  end
  
  describe "#to_crm_json" do
    it "formats the lead as expected by the CRM api" do
      @lead.created_at = Time.now
      json = @lead.to_crm_json
      
      expect(json).to eq(
        {
          name: @lead.name,
          company: @lead.company,
          email: @lead.email,
          phone: @lead.phone,
          city: @lead.city,
          state: @lead.state,
          country: @lead.country,
          project_description: @lead.project_description,
          source: @lead.source_for_crm,
          created_at: @lead.created_at.to_date.to_s
        }.to_json
      )
    end
  end
  
end
