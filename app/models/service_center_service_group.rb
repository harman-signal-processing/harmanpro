class ServiceCenterServiceGroup < ApplicationRecord
  belongs_to :service_center
  belongs_to :service_group

  validates :service_center, presence: true
  validates :service_group, presence: true, uniqueness: { scope: :service_center, case_sensitive: false }
end
