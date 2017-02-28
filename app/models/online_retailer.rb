class OnlineRetailer < ApplicationRecord
  extend FriendlyId
  friendly_id :name

  belongs_to :locale, class_name: "AvailableLocale", foreign_key: :locale_id

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, format: { with: URI.regexp }
  validates :locale, presence: true

  has_attached_file :logo,
    styles: {
      large: "250x156",
      medium: "125x78",
      small: "90x57",
      thumb: "83x52",
      thumb_square: "64x64#",
      circle: "72x72",
      tiny: "32x32#"
  }, default_url: "missing/logos/:style.jpg"

  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  def should_generate_new_friendly_id?
    true
  end

end
