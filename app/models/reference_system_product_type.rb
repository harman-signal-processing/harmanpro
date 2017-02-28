# Associates a ReferenceSystem with one or more ProductTypes. This
# class is manifest as icons on the system diagram for the Reference System,
# and becomes the container for related products.
#
class ReferenceSystemProductType < ApplicationRecord
  belongs_to :reference_system
  belongs_to :product_type
  has_many :reference_system_product_type_products, dependent: :destroy
  has_many :products, through: :reference_system_product_type_products

  validates :reference_system, presence: true
  validates :product_type, presence: true

  def name
    "#{reference_system.name}: #{product_type.name}"
  end
end
