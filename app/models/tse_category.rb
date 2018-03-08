class TseCategory < ApplicationRecord
  has_many :tse_category_contacts, dependent: :destroy
  has_many :tse_contacts, through: :tse_category_contacts
  validates :name, presence: true, uniqueness: true
  acts_as_tree

  def tree_name
    (parent_id.present? ? "--" : "") + name
  end

  def self.all_sorted
    where(parent_id: nil).map do |p|
      [p, where(parent_id: p.id)]
    end.flatten
  end

  # The default list of contacts needs to be in a specific order
  # (by category)
  def self.default_contact_sort_order
    product_expertise = where("name LIKE ?", '%product%').where(parent_id: nil)
    [product_expertise.first] + (where(parent_id: nil) - [product_expertise.first])
  end

end
