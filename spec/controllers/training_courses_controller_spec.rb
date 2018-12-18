require 'rails_helper'

RSpec.describe TrainingCoursesController, type: :controller do

  describe "GET index" do
    it "returns courses list" do
      skip "Training courses index path route was removed"
      get :index
      expect(response.successful?).to be true
      expect(response).to render_template("index")
    end
  end  #  describe "GET index" do

end  #  RSpec.describe TrainingCoursesController, type: :controller do
