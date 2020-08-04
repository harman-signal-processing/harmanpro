class DistributorInfo::DistributorCountry < ApplicationRecord
  belongs_to :distributor, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::Distributor'
  belongs_to :country, foreign_key: 'location_info_country_id', class_name: 'LocationInfo::Country'  
  
  validates :distributor_info_distributor_id, presence: true
  validates :location_info_country_id, presence: true, uniqueness: {scope: :distributor_info_distributor_id, case_sensitive: false}    
end
