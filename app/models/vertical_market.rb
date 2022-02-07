class VerticalMarket < ApplicationRecord
  translates :slug, :name, :headline, :description, :lead_form_content, :extra_content
  attribute :slug
  attribute :name
  attribute :headline
  attribute :description
  attribute :lead_form_content
  attribute :extra_content

  extend FriendlyId
  friendly_id :slug_candidates, use: [:globalize, :history, :finders]

  has_many :case_study_vertical_markets, dependent: :restrict_with_error, inverse_of: :vertical_market
  has_many :case_studies, through: :case_study_vertical_markets
  has_many :reference_systems, -> { order(Arel.sql("position ASC")) }, dependent: :restrict_with_error
  has_many :leads
  acts_as_tree #order: "name"

  has_attached_file :icon, {
    styles: {
      standard: "93x93#",
      thumb: "48x48#"
  }, processors: [:thumbnail, :compression],
  default_url: "missing/icon.png"}.merge(RACKSPACE_STORAGE)

  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\Z/

  has_attached_file :banner, {
    styles: {
      large: "1170x400#",
      medium: "500x200#",
      medium_gray: { geometry: "500x200#", processors: [:grayscale, :thumbnail] },
      small: "250x100#",
      thumb: "83x50#",
      thumb_square: "64x64#"
  }, processors: [:thumbnail, :compression],
  default_url: "missing/banners/:style.jpg"}.merge(RACKSPACE_STORAGE)

  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\Z/

  has_attached_file :background, {
    styles: {
      large: "1170x1755#",
      medium: "585x877#",
      small: "250x375#",
      thumb: "80x120#",
      thumb_square: "64x64#"
  }, processors: [:thumbnail, :compression],
  default_url: "missing/background/:style.jpg"}.merge(RACKSPACE_STORAGE)

  validates_attachment_content_type :background, content_type: /\Aimage\/.*\Z/

  has_attached_file :hef_banner, {
    styles: {
      large: "1170x1755#",
      medium: "585x877#",
      small: "250x375#",
      thumb: "80x120#",
      thumb_square: "64x64#"
  }, processors: [:thumbnail, :compression],
  default_url: "missing/hef_banner/:style.jpg"}.merge(RACKSPACE_STORAGE)

  validates_attachment_content_type :hef_banner, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :headline, presence: true

  accepts_nested_attributes_for :case_study_vertical_markets, reject_if: :all_blank, allow_destroy: true

  def self.active
    with_translations(I18n.locale).where(live: true)
  end

  def self.parent_verticals
    active.where("parent_id IS NULL or parent_id <= 0")
  end

  def self.active_child_verticals
    active.where(parent_id: parent_verticals.select(:id)).with_translations(I18n.locale).order(Arel.sql("name"))
  end

  def slug_candidates
    [
      :name,
      :headline,
      [:name, :headline]
    ]
  end

  def should_generate_new_friendly_id?
    true
  end

  def featured_reference_systems(limit = 6)
    reference_systems.limit(limit)
  end

  def featured_case_studies_ids
    case_study_vertical_markets.where(show_on_vertical_market_page: true).pluck(:case_study_id)
  end

  def featured_case_studies(limit = 3)
    @featured_case_studies ||= CaseStudy.with_translations(I18n.locale).where(id: featured_case_studies_ids).order(Arel.sql("RAND()")).limit(limit)
  end

  def all_diagrams_present?
    !!!( reference_systems.map{ |rs| rs.system_diagram.present? }.include?(false) )
  end

  # Only for top-level verticals, helps determine menu structure
  def children_or_reference_systems
    (self.children.where(live: true).size > 0) ? self.children.where(live: true).with_translations(I18n.locale).order(Arel.sql('name')) : self.reference_systems
  end

  # Link name for search results
  def link_name
    name
  end

  # Search results content preview
  def content_preview
    if description.present?
      description
    elsif headline.present?
      headline
    else
      name
    end
  end

end
