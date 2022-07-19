class CaseStudyBrand < ApplicationRecord
  belongs_to :case_study
  belongs_to :brand

  validates :case_study, uniqueness: { scope: :brand, case_sensitive: false }

end
