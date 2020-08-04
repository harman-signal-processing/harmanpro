class BrandDistributor < ApplicationRecord
  belongs_to :brand
  belongs_to :distributor

  validates :brand, presence: true, uniqueness: { scope: :distributor_id, case_sensitive: false }
  validates :distributor, presence: true
end
