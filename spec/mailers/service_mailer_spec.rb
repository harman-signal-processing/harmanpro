require "rails_helper"

RSpec.describe ServiceMailer, type: :mailer do
  describe "tech support message" do
    before do
      @contact_message = FactoryGirl.create(:contact_message, message_type: "tech_support")
    end

    let(:mail) { ServiceMailer.contact_form(@contact_message) }

    it "sends to the brand tech support email" do
      expect(mail.to).to eq([@contact_message.brand.tech_support_email])
    end

    it "has the tech support subject" do
      expect(mail.subject).to match("Technical Support")
    end
  end

  describe "parts message" do
    before do
      @contact_message = FactoryGirl.create(:contact_message, message_type: "parts_request")
    end

    let(:mail) { ServiceMailer.contact_form(@contact_message) }

    it "sends to the brand parts email" do
      expect(mail.to).to eq([@contact_message.brand.parts_email])
    end

    it "has the parts subject" do
      expect(mail.subject).to match("Parts Request")
    end
  end

  describe "repair message" do
    before do
      @contact_message = FactoryGirl.create(:contact_message, message_type: "repair_request")
    end

    let(:mail) { ServiceMailer.contact_form(@contact_message) }

    it "sends to the brand repair email" do
      expect(mail.to).to eq([@contact_message.brand.repair_email])
    end

    it "has the repair subject" do
      expect(mail.subject).to match("Repair Request")
    end
  end
end
