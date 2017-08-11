require 'rails_helper'

RSpec.describe EmeaPageResource, type: :model do

  before :all do
    @resource = FactoryGirl.create(:emea_page_resource)
  end

  subject { @resource }
  it { should respond_to :emea_page }
  it { should respond_to :attachment }
  it { should respond_to :featured? }
  it { should respond_to :link }
  it { should respond_to :new_window? }
end
