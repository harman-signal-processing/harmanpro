class ProductType < ApplicationRecord
  translates :slug, :name, :description
  attribute :slug
  attribute :name
  attribute :description

  extend FriendlyId
  friendly_id :name, use: :globalize

  has_many :reference_system_product_types, dependent: :destroy

  validates :name, presence: true,  uniqueness: true

  def should_generate_new_friendly_id?
    true
  end

end
