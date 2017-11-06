require 'rails_helper'

RSpec.describe ServiceCenterServiceGroup, type: :model do

  before :all do
    @service_center_service_group = FactoryBot.create(:service_center_service_group)
  end

  subject { @service_center_service_group }
  it { should respond_to :service_center }
  it { should respond_to :service_group }
end
