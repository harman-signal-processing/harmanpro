class ProductType < ApplicationRecord
  translates :slug, :name, :description
  attribute :slug
  attribute :name
  attribute :description

  extend FriendlyId
  friendly_id :name, use: [:globalize, :history, :finders]

  has_many :reference_system_product_types, dependent: :destroy
  has_many :new_product_product_types, dependent: :destroy, inverse_of: :product_type
  has_many :new_products, through: :new_product_product_types

  validates :name, presence: true,  uniqueness: { case_sensitive: false }

  def should_generate_new_friendly_id?
    true
  end

end
