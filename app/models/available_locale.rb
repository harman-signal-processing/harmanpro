# The I18n gem doesn't use this to determine which locales to load.
# This is just a way to correlate translators with their locales.
class AvailableLocale < ActiveRecord::Base
  extend FriendlyId
  friendly_id :key

  validates :key, presence: true, uniqueness: true
  validates :name, presence: true

  has_many :locale_translators, dependent: :destroy
  has_many :translators, through: :locale_translators
  has_many :menu_items, foreign_key: :locale_id
  has_many :landing_pages, foreign_key: :original_locale_id
  has_many :events, foreign_key: :original_locale_id
  has_many :news_articles, foreign_key: :locale_id
  has_many :artists, foreign_key: :locale_id, dependent: :destroy
  has_many :online_retailers, foreign_key: :locale_id, dependent: :destroy
  has_many :slides, -> { order("position ASC") }, foreign_key: :locale_id

  def self.default
    find_by(key: I18n.default_locale.to_s)
  end

  def self.default_id
    default.present? ? default.id : nil
  end

  def self.translatables
    %w(Brand CaseStudy Event LandingPage ProductType Product ReferenceSystem SiteSetting Venue VerticalMarket)
  end

  def self.live
    where(live: true).pluck(:key).map{|l| l.to_sym}
  end

  def items_to_translate
    @items_to_translate ||= self.class.translatables.map do |t|
      t.constantize.needing_translations(self.key)
    end.flatten
  end

  def homepage_slides
    slides.where("start_on IS NULL OR start_on <= ?", Date.today).where("end_on IS NULL OR end_on > ?", Date.today)
  end
end
