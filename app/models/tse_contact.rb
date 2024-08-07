class TseContact < ApplicationRecord
  has_many :tse_category_contacts, dependent: :destroy, inverse_of: :tse_contact
  has_many :tse_categories, through: :tse_category_contacts

  has_many :tse_contact_technologies, dependent: :destroy, inverse_of: :tse_contact
  has_many :tse_technologies, through: :tse_contact_technologies

  has_many :tse_contact_domains, dependent: :destroy, inverse_of: :tse_contact
  has_many :tse_domains, through: :tse_contact_domains

  has_many :tse_contact_regions, dependent: :destroy, inverse_of: :tse_contact
  has_many :tse_regions, through: :tse_contact_regions

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  accepts_nested_attributes_for :tse_category_contacts
  accepts_nested_attributes_for :tse_contact_technologies
  accepts_nested_attributes_for :tse_contact_domains
  accepts_nested_attributes_for :tse_contact_regions

  def tse_categories_flattened
    parents = tse_categories.where("parent_id > 0").pluck(:parent_id)
    children = tse_categories.pluck(:id)
    TseCategory.where(id: (parents + children).uniq)
  end
end
