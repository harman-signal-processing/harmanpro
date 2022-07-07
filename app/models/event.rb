class Event < ApplicationRecord
  translates :slug, :name, :description, :page_content
  attribute :slug
  attribute :name
  attribute :description
  attribute :page_content

  extend FriendlyId
  friendly_id :slug_candidates, use: [:globalize, :history, :finders]

  belongs_to :original_locale, class_name: "AvailableLocale", optional: true
  validates :name, presence: true
  validates :start_on, presence: true
  validates :end_on, presence: true

  has_attached_file :image,
    styles: {
      large: "1170x400#",
      medium: "500x200#",
      medium_gray: { geometry: "500x200#", processors: [:grayscale, :thumbnail] },
      small_panel: "500x312#",
      small: "250x100#",
      thumb: "83x50#",
      thumb_square: "64x64#"
  }, processors: [:thumbnail, :compression],
  default_url: "missing/banners/:style.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  attr_accessor :delete_image

  before_update :delete_image_if_needed

  def delete_image_if_needed
    unless self.image.dirty?
      if self.delete_image.present? && self.delete_image.to_s == "1"
        self.image = nil
      end
    end
  end

  def slug_candidates
    [
      :name,
      [:start_on, :name]
    ]
  end

  def should_generate_new_friendly_id?
    true
  end

  def self.current_and_upcoming
    where(active: true).where("end_on >= ?", Date.today).order(start_on: :asc)
  end

  def self.recent
    where(active: true).where("end_on <= ? AND end_on >= ?", Date.today, 6.months.ago).order(start_on: :desc)
  end

end
