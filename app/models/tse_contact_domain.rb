class TseContactDomain < ApplicationRecord
  belongs_to :tse_contact
  belongs_to :tse_domain

  validates :tse_contact, uniqueness: { scope: :tse_domain_id, case_sensitive: false }
end
