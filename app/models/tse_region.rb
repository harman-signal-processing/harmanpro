class TseRegion < ApplicationRecord
  has_many :tse_contact_regions, dependent: :destroy
  has_many :tse_contacts, through: :tse_contact_regions

  validates :name, presence: true, uniqueness: true
end
