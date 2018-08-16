class NewProductProductType < ApplicationRecord
  belongs_to :new_product
  belongs_to :product_type

  validates :new_product, presence: true
  validates :product_type, presence: true
end
