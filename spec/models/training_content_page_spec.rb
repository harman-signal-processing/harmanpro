require 'rails_helper'

RSpec.describe TrainingContentPage, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  before :all do
    @training_content_page = FactoryBot.create(:training_content_page)
  end  #  before :all do
  
  subject { @training_content_page }
  it { should respond_to :title }
  it { should respond_to :subtitle }
  it { should respond_to :right_content }
  it { should respond_to :main_content }
  it { should respond_to :sub_content }
  it { should respond_to :friendly_id }  
  
  describe ".main_content_width" do
      
    it "should be 9 with no side columns" do
      @training_content_page.right_content = ''
      expect(@training_content_page.main_content_width).to eq 9
    end  #  it "should be 9 with no side columns" do    
      
    it "should be 6 with one column" do
      @training_content_page.right_content = 'foo'
      expect(@training_content_page.main_content_width).to eq 6
    end  #  it "should be 6 with one column" do
      
  end  #  describe ".main_content_width" do
  
end  #  RSpec.describe TrainingContentPage, type: :model do
