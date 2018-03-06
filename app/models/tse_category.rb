class TseCategory < ApplicationRecord
  has_many :tse_category_contacts, dependent: :destroy
  has_many :tse_contacts, through: :tse_category_contacts
  validates :name, presence: true, uniqueness: true
  acts_as_tree

  def tree_name
    (parent_id.present? ? "--" : "") + name
  end
end
