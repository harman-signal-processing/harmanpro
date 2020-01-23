class Slide < ApplicationRecord

  belongs_to :locale, class_name: "AvailableLocale", foreign_key: :locale_id

  has_attached_file :background,
    styles: {
      large: "1170x624#",
      medium: "500x312#",
      small: "250x156#",
      thumb: "83x52#",
      thumb_square: "64x64#"
  }, processors: [:thumbnail, :compression],
  default_url: "missing/banners/:style.jpg"

  has_attached_file :bubble,
    styles: {
      large: "1170x624#",
      medium: "500x312#",
      small: "250x156#",
      thumb: "83x52#",
      thumb_square: "64x64#"
  }, processors: [:thumbnail, :compression],
  default_url: "missing/banners/:style.jpg"

  validates_attachment_content_type :background, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :bubble, content_type: /\Aimage\/.*\Z/
  validates :locale, presence: true
  validates :name, presence: true

  acts_as_list scope: :locale
  attr_accessor :delete_background
  before_update :delete_background_if_needed

  def locale_name
    locale.name
  end

  def delete_background_if_needed
    unless self.background.dirty?
      if self.delete_background.present? && self.delete_background.to_s == "1"
        self.background= nil
      end
    end
  end
end
