class ReferenceSystemProductTypeProduct < ApplicationRecord
  belongs_to :reference_system_product_type
  belongs_to :product

  validates :reference_system_product_type, presence: true
  validates :product, presence: true
end
