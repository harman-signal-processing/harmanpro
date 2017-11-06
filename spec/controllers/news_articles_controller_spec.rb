require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      article = FactoryBot.create(:news_article)
      get :show, params: { id: article.id }
      expect(response).to have_http_status(:success)
    end
  end

end
