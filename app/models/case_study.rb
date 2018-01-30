class CaseStudy < ApplicationRecord
  translates :slug, :headline, :description, :content
  attribute :slug
  attribute :headline
  attribute :description
  attribute :content

  extend FriendlyId
  friendly_id :slug_candidates, use: :globalize

  has_many :case_study_vertical_markets, dependent: :restrict_with_error, inverse_of: :case_study
  has_many :vertical_markets, through: :case_study_vertical_markets
  has_attached_file :banner,
    styles: {
      large: "1170x400",
      medium: "500x200",
      small_panel: "500x312#",
      small: "250x100",
      thumb: "83x50",
      thumb_square: "64x64#"
  }, default_url: "missing/banners/:style.jpg"
  has_attached_file :pdf

  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :pdf, content_type: /pdf/
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

  # Link name for search results
  def link_name
    "#{I18n.t :case_study}: " + headline
  end

  # Search results content preview
  def content_preview
    self.description.present? ? self.description : self.content
  end

end
