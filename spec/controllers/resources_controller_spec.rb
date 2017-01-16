require "rails_helper"

RSpec.describe ResourcesController do

  before :all do
    @resource = FactoryGirl.create(:resource)
  end

  # The show method becomes the permalink using the
  # resource's ID
  describe "GET :show" do

    before do
      get :show, params: { id: @resource.id }
    end

    it "returns the resource" do
      expect(assigns(:resource)).to eq(@resource)
      expect(response).to redirect_to(@resource.attachment.url)
    end
  end
end
