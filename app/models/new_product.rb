class NewProduct < ApplicationRecord
  has_many :new_product_brands, dependent: :destroy, inverse_of: :new_product
  has_many :brands, through: :new_product_brands

  validates :name, presence: true
  validates :released_on, presence: true

  has_attached_file :image,
    styles: {
      large: "1170x952#",
      medium: "500x407#",
      small: "250x200#",
      thumb: "83x50#",
      thumb_square: "64x64#"
  }, default_url: "missing/banners/:style.jpg"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  accepts_nested_attributes_for :new_product_brands, reject_if: :all_blank, allow_destroy: true
end
