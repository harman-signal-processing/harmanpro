class TseDomain < ApplicationRecord
  has_many :tse_contact_domains, dependent: :destroy
  has_many :tse_contacts, through: :tse_contact_domains

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
