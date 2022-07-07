class BrandNewsArticle < ApplicationRecord
  belongs_to :brand
  belongs_to :news_article

  validates :news_article, uniqueness: { scope: :brand_id, case_sensitive: false }
end
