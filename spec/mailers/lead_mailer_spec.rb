require "rails_helper"

RSpec.describe LeadMailer, type: :mailer do

  before :all do
    skip "Mailer hangs when run with entire suite"
    FactoryGirl.create(:site_setting, name: "leadgen-recipients", content: "foo@foo.com, bar@bar.com")
    FactoryGirl.create(:site_setting, name: "leadgen-sender", content: "leadgen@domain.com")
    @lead = FactoryGirl.create(:lead)
  end

  describe "new_lead" do
    let(:mail) { LeadMailer.new_lead(@lead) }

    it "renders the headers" do
      expect(mail.subject).to include("New lead")
      expect(mail.to).to include("foo@foo.com")
      expect(mail.to).to include("bar@bar.com")
      expect(mail.from).to eq(["leadgen@domain.com"])
    end

    it "renders the body" do
      body = mail.body.encoded
      expect(body).to match("The following")
      expect(body).to match(@lead.name)
      expect(body).to match(@lead.location)
      expect(body).to match(@lead.email)
    end
  end

end
