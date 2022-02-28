class Resource < ApplicationRecord
  acts_as_taggable

  has_attached_file :attachment, RESOURCES_STORAGE
  do_not_validate_attachment_file_type :attachment

  has_attached_file :image, {
    styles: {
      large: "640x480",
      medium: "320x240",
      small: "160x120",
      thumb: "80x60",
      thumb_square: "64x64#",
      tiny: "32x32#"
  }, processors: [:thumbnail, :compression],
  default_url: "missing/logos/:style.jpg"}

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
