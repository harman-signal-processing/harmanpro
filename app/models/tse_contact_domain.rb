class TseContactDomain < ApplicationRecord
  belongs_to :tse_contact
  belongs_to :tse_domain

  validates :tse_domain, presence: true
  validates :tse_contact, presence: true, uniqueness: { scope: :tse_domain_id }
end
