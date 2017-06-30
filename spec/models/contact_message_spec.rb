require "rails_helper"

RSpec.describe ContactMessage, :type => :model do
  before do
    @brand = FactoryGirl.create(:brand)
    @contact_message = FactoryGirl.build(:contact_message, brand: @brand)
  end

  subject { @contact_message }
  it { should respond_to :brand }

  describe "tech support" do
    it "should deliver email to brand's tech support"
  end

  describe "parts request" do
    it "should deliver email to brand's parts address"
  end

  describe "repair request" do
    it "should deliver email to brand's repair address"
  end
end
