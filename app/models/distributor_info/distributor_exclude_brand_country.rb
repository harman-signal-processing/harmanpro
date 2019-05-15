class DistributorInfo::DistributorExcludeBrandCountry < ApplicationRecord
  belongs_to :distributor, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::Distributor'
  belongs_to :country, foreign_key: 'location_info_country_id', class_name: 'LocationInfo::Country'  
  belongs_to :brand, foreign_key: 'brand_id', class_name: 'Brand'
  
  validates :distributor_info_distributor_id, presence: true
  validates :location_info_country_id, presence: true, uniqueness: {scope: [:distributor_info_distributor_id, :brand_id]}   
  validates :brand_id, presence: true, uniqueness: {scope: [:distributor_info_distributor_id, :location_info_country_id]}
end
