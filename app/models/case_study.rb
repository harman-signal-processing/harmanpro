class CaseStudy < ActiveRecord::Base
  translates :slug, :headline, :description, :content
  extend FriendlyId
  friendly_id :slug_candidates, use: :globalize

  has_many :case_study_vertical_markets, dependent: :restrict_with_error, inverse_of: :case_study
  has_many :vertical_markets, through: :case_study_vertical_markets
  has_attached_file :banner,
    styles: {
      large: "1170x624",
      medium: "500x312",
      small: "250x156",
      thumb: "83x52",
      thumb_square: "64x64#"
  }, default_url: "missing/banners/:style.jpg"

  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\Z/
  validates :headline, presence: true, uniqueness: true

  accepts_nested_attributes_for :case_study_vertical_markets, reject_if: :all_blank, allow_destroy: true

  def self.featured
    CaseStudyVerticalMarket.featured.map{|c| c.case_study}
  end

  def slug_candidates
    [
      :headline,
    ]
  end

  def should_generate_new_friendly_id?
    true
  end

  def name
    headline
  end

end
