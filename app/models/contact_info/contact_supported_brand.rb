class ContactInfo::ContactSupportedBrand < ApplicationRecord
  belongs_to :contact, foreign_key: 'contact_info_contact_id', class_name: 'ContactInfo::Contact'
  belongs_to :brand, foreign_key: 'brand_id', class_name: 'Brand'  
  
  validates :contact_info_contact_id, presence: true
  validates :brand_id, presence: true, uniqueness: {scope: :contact_info_contact_id}  
end
