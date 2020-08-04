class DistributorInfo::DistributorContact < ApplicationRecord
  belongs_to :distributor, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::Distributor'
  belongs_to :contact, foreign_key: 'contact_info_contact_id', class_name: 'ContactInfo::Contact'  
  
  validates :distributor_info_distributor_id, presence: true
  validates :contact_info_contact_id, presence: true, uniqueness: {scope: :distributor_info_distributor_id, case_sensitive: false}  
end
