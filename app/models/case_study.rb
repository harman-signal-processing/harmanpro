class CaseStudy < ActiveRecord::Base
  translates :slug, :headline, :description, :content
  extend FriendlyId
  friendly_id :slug_candidates, use: :globalize

  belongs_to :vertical_market
  has_attached_file :banner,
    styles: {
      large: "1170x624",
      medium: "500x312",
      small: "250x156",
      thumb: "83x52",
      thumb_square: "64x64#"
  }, default_url: "missing/banners/:style.jpg"

  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\Z/
  validates :headline, presence: true, uniqueness: { scope: :vertical_market_id }
  validates :vertical_market, presence: true

  def self.featured
    active_vertical_markets = VerticalMarket.where(live: true).pluck(:id)
    where(vertical_market_id: active_vertical_markets).
      order("RAND()").limit(10)
  end

  def slug_candidates
    [
      :headline,
      [:vertical_market_name, :headline]
    ]
  end

  def should_generate_new_friendly_id?
    true
  end

  def vertical_market_name
    vertical_market.name
  end

  def name
    headline
  end

end
