class Slide < ActiveRecord::Base

  belongs_to :locale, class_name: "AvailableLocale", foreign_key: :locale_id

  has_attached_file :background,
    styles: {
      large: "1170x624#",
      medium: "500x312#",
      small: "250x156#",
      thumb: "83x52#",
      thumb_square: "64x64#"
  }, default_url: "missing/banners/:style.jpg"

  has_attached_file :bubble,
    styles: {
      large: "1170x624#",
      medium: "500x312#",
      small: "250x156#",
      thumb: "83x52#",
      thumb_square: "64x64#"
  }, default_url: "missing/banners/:style.jpg"

  validates_attachment_content_type :background, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :bubble, content_type: /\Aimage\/.*\Z/
  validates :locale, presence: true
  validates :name, presence: true

  acts_as_list scope: :locale

  def locale_name
    locale.name
  end
end
