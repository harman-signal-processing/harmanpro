class TseCategoryContact < ApplicationRecord
  belongs_to :tse_category
  belongs_to :tse_contact
  
  validates :tse_contact, uniqueness: { scope: :tse_category_id, case_sensitive: false }
end
