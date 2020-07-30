require 'rails_helper'

RSpec.describe MainController do

  describe "GET sitemap.xml" do

    before do
      get :sitemap, params: { format: :xml }
    end

    it "renders sitemap XML template" do
      expect(response).to render_template("sitemap")
    end
  end

  describe "GET sitemap (html)" do

    before do
      @vertical_market = FactoryBot.create(:vertical_market)
      get :sitemap
    end

    it "renders sitemap page" do
      expect(response).to render_template("sitemap")
    end
  end

  describe "GET sureroute-test-object (html)" do

    before do
      get :sureroute, params: { format: :html }
    end

    it "renders the template" do
      expect(response).to render_template("sureroute")
    end
  end

end
