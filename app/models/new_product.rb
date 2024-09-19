class NewProduct < ApplicationRecord
  translates :name, :content, :more_info, :press_release
  attribute :name
  attribute :content
  attribute :more_info
  attribute :press_release

  has_many :new_product_brands, dependent: :destroy, inverse_of: :new_product
  has_many :brands, through: :new_product_brands
  has_many :new_product_product_types, dependent: :destroy, inverse_of: :new_product
  has_many :product_types, through: :new_product_product_types

  validates :name, presence: true
  validates :released_on, presence: true

  has_attached_file :image,
    styles: {
      large: "1170x952#",
      medium: "500x407#",
      small: "250x200#",
      thumb: "83x50#",
      thumb_square: "64x64#"
  }, processors: [:thumbnail, :compression],
  default_url: "missing/banners/:style.jpg"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  accepts_nested_attributes_for :new_product_brands, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :new_product_product_types, reject_if: :all_blank, allow_destroy: true
  
  scope :for_index, -> do
    where("released_on <= ?", Date.today).order(Arel.sql("released_on DESC"))
  end
  
  scope :featured, -> do
    for_index.limit(8)
  end
    
end
