class Artist < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates

  belongs_to :locale, class_name: "AvailableLocale", foreign_key: :locale_id

  has_attached_file :photo,
    styles: {
      large: "1170x624#",
      medium: "500x312#",
      small: "250x156#",
      thumb: "83x52#",
      thumb_square: "64x64#"
  }, processors: [:thumbnail, :compression],
  default_url: "missing/banners/:style.jpg"

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates :locale, presence: true
  validates :name, presence: true, uniqueness: { scope: :locale_id }

  attr_accessor :delete_photo

  before_update :delete_photo_if_needed

  # :nocov:
  def slug_candidates
    [
      :name,
      [:name, :locale_name]
    ]
  end

  def should_generate_new_friendly_id?
    true
  end

  def locale_name
    locale.name
  end
  # :nocov:

  def delete_photo_if_needed
    unless self.photo.dirty?
      if self.delete_photo.present? && self.delete_photo.to_s == "1"
        self.photo = nil
      end
    end
  end

end
