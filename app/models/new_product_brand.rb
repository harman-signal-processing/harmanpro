class NewProductBrand < ApplicationRecord
  belongs_to :new_product
  belongs_to :brand

  validates :new_product_id, presence: true
  validates :brand, presence: true
end
