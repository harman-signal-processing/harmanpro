class TseCategory < ApplicationRecord
  has_many :tse_category_contacts, dependent: :destroy
  has_many :tse_contacts, through: :tse_category_contacts
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  acts_as_list
  acts_as_tree

  def tree_name
    (parent_id.present? ? " ... " : "") + name
  end

  def self.all_sorted
    ordered_parents.map do |p|
      [p, where(parent_id: p.id).order(:position)]
    end.flatten
  end

  def self.ordered_parents
    where(parent_id: nil).order(:position)
  end

end
