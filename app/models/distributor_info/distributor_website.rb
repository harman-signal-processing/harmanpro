class DistributorInfo::DistributorWebsite < ApplicationRecord
  belongs_to :distributor, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::Distributor'
  belongs_to :website, foreign_key: 'contact_info_website_id', class_name: 'ContactInfo::Website'  
  
  validates :distributor_info_distributor_id, presence: true
  validates :contact_info_website_id, presence: true, uniqueness: {scope: :distributor_info_distributor_id}  
end
