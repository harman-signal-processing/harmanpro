class ServiceCenter < ApplicationRecord
  has_many :service_center_service_groups, inverse_of: :service_center, dependent: :destroy
  has_many :service_groups, through: :service_center_service_groups

  validates :willingness, acceptance: true, on: :create
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :contact_name, presence: true
  validates :email, presence: true
  validates :zip, presence: true

  accepts_nested_attributes_for :service_center_service_groups, reject_if: :all_blank, allow_destroy: true

  def self.active
    where(active: true).includes(:service_center_service_groups, :service_groups)
  end

  def self.states
    pluck(:state).uniq.sort
  end

end
