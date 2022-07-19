class MediaCoverage < ApplicationRecord
  extend FriendlyId
  friendly_id :headline

  belongs_to :media_outlet
  has_many :brand_media_coverages, dependent: :destroy
  has_many :brands, through: :brand_media_coverages

  validates :link, presence: true
  validates :headline, presence: true

  accepts_nested_attributes_for :brand_media_coverages, reject_if: :all_blank, allow_destroy: true

  scope :live, -> do
    where("news_date <= ?", Date.today).order(Arel.sql("news_date DESC"))
  end
end
