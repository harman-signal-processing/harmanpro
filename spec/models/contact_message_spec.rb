require "rails_helper"

RSpec.describe ContactMessage, :type => :model do
  before :all do
    @brand = FactoryBot.build(:brand)
    @contact_message = FactoryBot.build(:contact_message, brand: @brand)
  end

  subject { @contact_message }
  it { should respond_to :brand }

  describe "tech support" do
    it "should deliver email to brand's tech support" do
      contact_message = FactoryBot.build(:contact_message, brand: @brand, message_type: "tech_support")

      expect(contact_message.recipient).to eq(@brand.tech_support_email)
    end
  end

  describe "parts request" do
    it "should deliver email to brand's parts address" do
      contact_message = FactoryBot.build(:contact_message, brand: @brand, message_type: "parts_request")

      expect(contact_message.recipient).to eq(@brand.parts_email)
    end
  end

  describe "repair request" do
    it "should deliver email to brand's repair address" do
      contact_message = FactoryBot.build(:contact_message, brand: @brand, message_type: "repair_request")

      expect(contact_message.recipient).to eq(@brand.repair_email)
    end
  end
end
