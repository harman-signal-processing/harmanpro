require 'rails_helper'

RSpec.describe ServiceCenter, type: :model do

  before :all do
    @service_center = FactoryBot.create(:service_center, active: true)
  end

  subject { @service_center }
  it { should respond_to :contact_name }
  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :zip }
  it { should respond_to :willingness }
  it { should respond_to :active? }
  it { should respond_to :service_center_service_groups }
  it { should respond_to :service_groups }

  describe "deleting" do
    it "deletes any related ServiceCenterServiceGroups" do
      service_center_service_group = FactoryBot.create(:service_center_service_group)
      service_center = service_center_service_group.service_center
      service_group = service_center_service_group.service_group

      service_center.destroy

      expect(ServiceCenterServiceGroup.exists?(service_center_service_group.id)).to be(false)
      expect(ServiceGroup.exists?(service_group.id)).to be(true)
    end
  end

  it ".active should select only active service centers" do
    inactive_service_center = FactoryBot.create(:service_center, active: false)

    results = ServiceCenter.active

    expect(results).to include(@service_center)
    expect(results).not_to include(inactive_service_center)
  end

  it "#states collects and sorts US states" do
    states = ServiceCenter.states

    expect(states).to be_an(Array)
    expect(states).to include(@service_center.state)
  end

end
