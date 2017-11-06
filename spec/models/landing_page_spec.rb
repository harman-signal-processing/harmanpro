require 'rails_helper'

RSpec.describe LandingPage, type: :model do

  before :all do
    @landing_page = FactoryBot.create(:landing_page)
  end

  subject { @landing_page }
  it { should respond_to :title }
  it { should respond_to :subtitle }
  it { should respond_to :right_content }
  it { should respond_to :left_content }
  it { should respond_to :main_content }
  it { should respond_to :sub_content }
  it { should respond_to :friendly_id }

  describe ".main_content_width" do
    it "should be 12 with no side columns" do
      @landing_page.left_content = ''
      @landing_page.right_content = ''

      expect(@landing_page.main_content_width).to eq 12
    end

    it "should be 9 with one column" do
      @landing_page.left_content = 'foo'
      @landing_page.right_content = ''

      expect(@landing_page.main_content_width).to eq 9
    end

    it "should be 6 with two columns" do
      @landing_page.left_content = 'foo'
      @landing_page.right_content = 'foo2'

      expect(@landing_page.main_content_width).to eq 6
    end
  end
end
