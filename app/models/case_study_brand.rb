class CaseStudyBrand < ApplicationRecord
  belongs_to :case_study
  belongs_to :brand
  
  validates :brand, presence: true
  validates :case_study, presence: true, uniqueness: {scope: :brand} 
  
end  #  class CaseStudyBrand < ApplicationRecord
