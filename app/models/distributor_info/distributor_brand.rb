class DistributorInfo::DistributorBrand < ApplicationRecord
  belongs_to :distributor, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::Distributor'
  belongs_to :brand, foreign_key: 'brand_id', class_name: 'Brand'
  
  validates :distributor_info_distributor_id, presence: true
  validates :brand_id, presence: true, uniqueness: {scope: :distributor_info_distributor_id}
end
