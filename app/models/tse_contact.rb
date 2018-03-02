class TseContact < ApplicationRecord
  has_many :tse_category_contacts, dependent: :destroy
  has_many :tse_categories, through: :tse_category_contacts

  has_many :tse_contact_technologies, dependent: :destroy
  has_many :tse_technologies, through: :tse_contact_technologies

  has_many :tse_contact_domains, dependent: :destroy
  has_many :tse_domains, through: :tse_contact_domains

  has_many :tse_contact_regions, dependent: :destroy
  has_many :tse_regions, through: :tse_contact_regions

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
