class ServiceGroup < ApplicationRecord
  belongs_to :brand
  has_many :service_center_service_groups, dependent: :destroy
  has_many :service_centers, through: :service_center_service_groups

  validates :brand, presence: true
  validates :name, presence: true, uniqueness: true

  def self.names
    order("UPPER(name)").pluck(:name).uniq
  end
end
