class TseContactRegion < ApplicationRecord
  belongs_to :tse_contact
  belongs_to :tse_region

  validates :tse_region, presence: true
  validates :tse_contact, presence: true, uniqueness: { scope: :tse_region_id }
end
