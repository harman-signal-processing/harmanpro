class NewsArticle < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates

  has_many :brand_news_articles, dependent: :destroy, inverse_of: :news_article
  has_many :brands, through: :brand_news_articles
  belongs_to :locale, class_name: "AvailableLocale", foreign_key: :locale_id

  has_attached_file :news_photo,
    styles: {
      large: "1170x400#",
      medium: "500x200#",
      medium_panel: "565x445#",
      small_panel: "500x312#",
      small: "250x100#",
      thumb: "83x50#",
      thumb_square: "64x64#"
  }, processors: [:thumbnail, :compression],
  default_url: "missing/banners/:style.jpg"
  validates_attachment_content_type :news_photo, content_type: /\Aimage\/.*\Z/
  
  has_attached_file :narrow_banner,
    styles: {
      large: "1170x400#",
      medium: "500x200#",
      medium_panel: "565x445#",
      small_panel: "500x312#",
      small: "250x100#",
      thumb: "83x50#",
      thumb_square: "64x64#"
  }, processors: [:thumbnail, :compression],
  default_url: "missing/banners/:style.jpg"
  validates_attachment_content_type :narrow_banner, content_type: /\Aimage\/.*\Z/
  
  validates :title, presence: true
  validates :post_at, presence: true

  accepts_nested_attributes_for :brand_news_articles, reject_if: :all_blank, allow_destroy: true

  attr_accessor :delete_photo

  before_update :delete_photo_if_needed

  # :nocov:
  def slug_candidates
    [
      :title,
      [:title, :locale],
      [:post_at, :title, :locale]
    ]
  end

  def should_generate_new_friendly_id?
    true
  end
  # :nocov:

  def self.featured
    where("post_at <= ?", Time.now).order("post_at DESC").limit(8)
  end

  def delete_photo_if_needed
    unless self.news_photo.dirty?
      if self.delete_photo.present? && self.delete_photo.to_s == "1"
        self.news_photo = nil
      end
    end
  end
  
  def post_on
    self.post_at.to_date
  end
end
