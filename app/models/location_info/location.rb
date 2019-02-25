class LocationInfo::Location < ApplicationRecord
  validates :name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :country, presence: true
  
  has_many :location_to_contacts_association, dependent: :destroy, foreign_key: 'location_info_location_id', class_name: 'LocationInfo::LocationContact'
  has_many :contacts, through: :location_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'  
  
  has_many :location_to_regions_association, dependent: :destroy, foreign_key: 'location_info_location_id', class_name: 'LocationInfo::LocationRegion'
  has_many :regions, through: :location_to_regions_association, source: :region, class_name: 'LocationInfo::Region'
end
