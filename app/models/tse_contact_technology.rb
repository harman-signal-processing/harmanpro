class TseContactTechnology < ApplicationRecord
  belongs_to :tse_contact
  belongs_to :tse_technology

  validates :tse_technology, presence: true
  validates :tse_contact, presence: true, uniqueness: { scope: :tse_technology_id, case_sensitive: false }
end
