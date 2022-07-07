class BrandDistributor < ApplicationRecord
  belongs_to :brand
  belongs_to :distributor

  validates :brand, uniqueness: { scope: :distributor_id, case_sensitive: false }
end
