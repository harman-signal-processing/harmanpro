class TseContactRegion < ApplicationRecord
  belongs_to :tse_contact
  belongs_to :tse_region

  validates :tse_contact, uniqueness: { scope: :tse_region_id, case_sensitive: false }
end
