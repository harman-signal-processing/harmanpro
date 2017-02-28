class BrandNewsArticle < ApplicationRecord
  belongs_to :brand
  belongs_to :news_article

  validates :brand, presence: true
  validates :news_article, presence: true, uniqueness: { scope: :brand_id }
end
