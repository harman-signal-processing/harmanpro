require 'rails_helper'

RSpec.describe ServiceGroup, type: :model do

  before :all do
    @service_group = FactoryBot.create(:service_group)
  end

  subject { @service_group }
  it { should respond_to :brand }
  it { should respond_to :service_center_service_groups }
  it { should respond_to :service_centers }

  describe "deleting" do
    it "deletes any related ServiceCenterServiceGroups" do
      service_center_service_group = FactoryBot.create(:service_center_service_group)
      service_center = service_center_service_group.service_center
      service_group = service_center_service_group.service_group

      service_group.destroy

      expect(ServiceCenterServiceGroup.exists?(service_center_service_group.id)).to be(false)
      expect(ServiceCenter.exists?(service_center.id)).to be(true)
    end
  end

  it "#names collects group names" do
    names = ServiceGroup.names

    expect(names).to be_an(Array)
    expect(names).to include(@service_group.name)
  end
end
