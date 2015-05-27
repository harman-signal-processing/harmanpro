class ServiceGroup < ActiveRecord::Base
  belongs_to :brand
  has_many :service_center_service_groups
  has_many :service_centers, through: :service_center_service_groups

  validates :brand, presence: true
  validates :name, presence: true, uniqueness: true

end