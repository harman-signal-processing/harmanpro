require 'rails_helper'

RSpec.describe "news_articles/show", type: :view do

  before :all do
    @news_article = FactoryBot.create(:news_article)

    assign(:news_article, @news_article)
  end

  before :each do
    render
  end

  it "should show the news content" do
    expect(rendered).to have_content(@news_article.body)
  end

end
