class TseTechnology < ApplicationRecord
  has_many :tse_contact_technologies, dependent: :destroy
  has_many :tse_contacts, through: :tse_contact_technologies

  validates :name, presence: true, uniqueness: true
end
