class Distributor < ApplicationRecord

  has_many :brand_distributors, dependent: :destroy, inverse_of: :distributor
  has_many :brands, through: :brand_distributors

  validates :name, :country, :region, presence: true

  accepts_nested_attributes_for :brand_distributors
end
