class TseRegion < ApplicationRecord
  has_many :tse_contact_regions, dependent: :destroy
  has_many :tse_contacts, through: :tse_contact_regions

  validates :name, presence: true, uniqueness: true

  acts_as_tree

  def tree_name
    (parent_id.present? ? " ... " : "") + name
  end

  def self.all_sorted
    where(parent_id: nil).order(:name).map do |p|
      [p, where(parent_id: p.id)]
    end.flatten
  end
end
