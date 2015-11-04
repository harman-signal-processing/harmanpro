require 'rails_helper'

RSpec.describe Resource, type: :model do

  before :all do
    @resource = FactoryGirl.create(:resource)
  end

  subject { @resource }
  it { should respond_to :name }
  it { should respond_to :resource_type }
  it { should respond_to :description }
  it { should respond_to :tags }
  it { should respond_to :attachment }

end
