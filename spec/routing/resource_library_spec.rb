require "rails_helper"

RSpec.describe "Resource Library Routes" do

  before :all do
    @resource = FactoryBot.create(:resource)
  end

  it "answers on permalink" do
    expect(get: "/resource-library/#{ @resource.to_param }").to route_to(
      controller: "resources",
      action: "show",
      id: @resource.to_param
    )
  end

end
