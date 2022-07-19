class TseContactTechnology < ApplicationRecord
  belongs_to :tse_contact
  belongs_to :tse_technology

  validates :tse_contact, uniqueness: { scope: :tse_technology_id, case_sensitive: false }
end
