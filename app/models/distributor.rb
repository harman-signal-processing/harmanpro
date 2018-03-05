class Distributor < ApplicationRecord

  has_many :brand_distributors, dependent: :destroy
  has_many :brands, through: :brand_distributors

  validates :name, :country, :region, presence: true
end
