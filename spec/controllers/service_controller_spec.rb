require "rails_helper"

RSpec.describe ServiceController, as: :controller do

  describe "GET index" do

    it "renders the template" do
      get :index

      expect(response.successful?).to be true
      expect(response).to render_template('index')
    end

  end
end
