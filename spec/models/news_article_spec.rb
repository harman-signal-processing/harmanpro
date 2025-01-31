require 'rails_helper'

RSpec.describe NewsArticle, type: :model do

  before :all do
    @news_article = FactoryBot.build(:news_article)
  end

  subject { @news_article }
  it { should respond_to :title }
  it { should respond_to :body }
  it { should respond_to :keywords }
  it { should respond_to :post_at }
  it { should respond_to :locale }
  it { should respond_to :brands }
end
