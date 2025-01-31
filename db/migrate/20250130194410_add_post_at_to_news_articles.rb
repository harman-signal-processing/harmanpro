class AddPostAtToNewsArticles < ActiveRecord::Migration[8.0]
  def up
    add_column :news_articles, :post_at, :datetime
    NewsArticle.find_each{|na| na.update_column(:post_at, na.post_on.to_time)}
    remove_column :news_articles, :post_on
  end
  
  def down
    add_column :news_articles, :post_on, :date
    NewsArticle.find_each{|na| na.update_column(:post_on, na.post_at.to_date)}
    remove_column :news_articles, :post_at
  end
end
