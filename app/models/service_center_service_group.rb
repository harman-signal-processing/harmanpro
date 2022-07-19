class ServiceCenterServiceGroup < ApplicationRecord
  belongs_to :service_center
  belongs_to :service_group

  validates :service_group, uniqueness: { scope: :service_center, case_sensitive: false }
end
