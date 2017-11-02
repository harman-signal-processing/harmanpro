class EmeaEmployeeContact < ApplicationRecord
  validates :department, :job_function, :name, presence: true
end
