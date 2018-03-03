class BrandDistributor < ApplicationRecord
  belongs_to :brand
  belongs_to :distributor

  validates :brand_id, presence: true
  validates :distributor_id, presence: true, uniqueness: { scope: :brand_id }
end
