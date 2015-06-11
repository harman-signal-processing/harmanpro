class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  belongs_to :brand
  has_many :reference_system_product_type_products, dependent: :destroy

  has_attached_file :photo,
    styles: {
      large: "1000x624",
      medium: "500x312",
      small: "250x156",
      thumb: "83x52",
      thumb_square: "64x64#",
      tiny: "32x32#"
  }, default_url: "missing/banners/:style.jpg"

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true, uniqueness: true
  validates :brand, presence: true

  # :nocov:
  def slug_candidates
    [
      :name,
      [:brand_name, :name]
    ]
  end

  def should_generate_new_friendly_id?
    true
  end
  # :nocov:

  def brand_name
    brand.name
  end

  def buy_now_url
    @buy_now_url ||= ecommerce_enabled? ? (ENV['buy_now_url_template'] % ecommerce_id) : ''
  end

  def ecommerce_enabled?
    !!(ecommerce_id.present?)
  end

end
