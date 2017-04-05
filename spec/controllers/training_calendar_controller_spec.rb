require 'rails_helper'

RSpec.describe TrainingCalendarController, type: :controller do

  describe "GET index" do
    it "returns training classroom schedule list" do
      get :index
      expect(response).to be_success
      expect(response).to render_template("index")
    end
  end  #  describe "GET index" do

end
