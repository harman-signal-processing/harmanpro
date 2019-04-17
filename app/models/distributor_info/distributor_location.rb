class DistributorInfo::DistributorLocation < ApplicationRecord
  belongs_to :distributor, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::Distributor'
  belongs_to :location, foreign_key: 'location_info_location_id', class_name: 'LocationInfo::Location'  
  
  validates :distributor_info_distributor_id, presence: true
  validates :location_info_location_id, presence: true, uniqueness: {scope: :distributor_info_distributor_id}  
end
