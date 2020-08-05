class Cms::NewsArticlesController < CmsController
  before_action :set_locale_for_translator

  def index
    if @available_locale
      @news_articles = @available_locale.news_articles
      render template: 'cms/available_locales/news_articles/index' and return false
    end
  end

  def new
    @news_article = NewsArticle.new
    render template: 'cms/available_locales/news_articles/new' and return false
  end

  def create
    @news_article = NewsArticle.new(news_article_params)
    @news_article.locale = @available_locale

    if @news_article.save
      redirect_to [:cms, @available_locale, @news_article.class], notice: "News Article was created"
    else
      render template: 'cms/available_locales/news_articles/new'
    end
  end

  def show
    @news_article = NewsArticle.find(params[:id])
    render template: 'cms/available_locales/news_articles/edit' and return false
  end

  def edit
    @news_article = NewsArticle.find(params[:id])
    render template: 'cms/available_locales/news_articles/edit' and return false
  end

  def update
    @news_article = NewsArticle.find(params[:id])
    if @news_article.update(news_article_params)
      redirect_to [:cms, @available_locale, @news_article.class], notice: 'Update successful'
    else
      render template: 'cms/available_locales/news_articles/edit'
    end
  end

  def destroy
    @news_article = NewsArticle.find(params[:id])
    @news_article.destroy
    redirect_to [:cms, @available_locale, @news_article.class], notice: "News Article was deleted."
  end

  private

  def news_article_params
    params.require(:news_article).permit(
      :title,
      :body,
      :keywords,
      :post_on,
      :news_photo,
      :quote,
      :delete_photo
    )
  end
end
