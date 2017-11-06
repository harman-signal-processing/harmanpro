require "rails_helper"

RSpec.describe ServiceCenterMailer, type: :mailer do
  describe "registration" do
    before do
      @service_center = FactoryBot.create(:service_center)
    end

    let(:mail) { ServiceCenterMailer.registration(@service_center) }

    it "renders the headers" do
      expect(mail.subject).to eq("Service Center Registration")
      expect(mail.to).to eq([ENV['service_center_registration_recipient']])
      expect(mail.from).to eq([@service_center.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(@service_center.name)
    end
  end

end
