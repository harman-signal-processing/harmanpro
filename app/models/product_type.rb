class ProductType < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name

  translates :name, :description

  has_many :reference_system_product_types, dependent: :destroy

  validates :name, presence: true,  uniqueness: true

  def should_generate_new_friendly_id?
    true
  end

end
