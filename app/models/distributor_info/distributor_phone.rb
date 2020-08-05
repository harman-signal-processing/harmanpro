class DistributorInfo::DistributorPhone < ApplicationRecord
  belongs_to :distributor, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::Distributor'
  belongs_to :phone, foreign_key: 'contact_info_phone_id', class_name: 'ContactInfo::Phone'  
  
  validates :distributor_info_distributor_id, presence: true
  validates :contact_info_phone_id, presence: true, uniqueness: {scope: :distributor_info_distributor_id, case_sensitive: false}  
end
