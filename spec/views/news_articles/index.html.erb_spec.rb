require 'rails_helper'

RSpec.describe "news_articles/index.html.erb", type: :view do
  before :all do
    @news_article = FactoryBot.create(:news_article)
    @featured_news = FactoryBot.create(:news_article, title: "Featured Article")

    assign(:news_articles,  [@news_article])
    assign(:featured_article, @featured_news)
  end

  before :each do
    render
  end

  it "should show the news title" do
    expect(rendered).to have_link(@news_article.title)
  end

  it "should show the featured news title" do
    expect(rendered).to have_content @featured_news.title
  end
end
