class MediaOutlet < ApplicationRecord
  extend FriendlyId
  friendly_id :name

  has_many :media_coverages
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_attached_file :logo, {
    styles: {
      large: "250x156",
      medium: "125x78",
      small: "90x57",
      thumb: "83x52",
      thumb_square: "64x64#",
      circle: "72x72",
      tiny: "32x32#"
    }, default_url: "missing/logos/:style.jpg"}.merge(RACKSPACE_STORAGE)
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

end
