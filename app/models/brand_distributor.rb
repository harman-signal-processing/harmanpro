class BrandDistributor < ApplicationRecord
  belongs_to :brand
  belongs_to :distributor

  validates :brand, presence: true, uniqueness: { scope: :distributor_id }
  validates :distributor, presence: true
end
