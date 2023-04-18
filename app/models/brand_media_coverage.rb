class BrandMediaCoverage < ApplicationRecord
  belongs_to :brand
  belongs_to :media_coverage

  scope :unique_brand_ids, -> { pluck(:brand_id).uniq }

end
