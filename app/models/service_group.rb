class ServiceGroup < ApplicationRecord
  belongs_to :brand
  has_many :service_center_service_groups, dependent: :destroy
  has_many :service_centers, through: :service_center_service_groups

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.names
    order(Arel.sql("UPPER(name)")).pluck(:name).uniq
  end
end
