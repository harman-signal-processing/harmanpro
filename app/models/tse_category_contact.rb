class TseCategoryContact < ApplicationRecord
  belongs_to :tse_category
  belongs_to :tse_contact
  validates :tse_category, presence: true
  validates :tse_contact, presence: true, uniqueness: { scope: :tse_category_id }
end
