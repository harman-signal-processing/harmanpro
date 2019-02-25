class DistributorInfo::Distributor < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :distributor_brands, dependent: :destroy, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::DistributorBrand'
  has_many :brands, through: :distributor_brands, source: :brand, class_name: 'Brand'
end
