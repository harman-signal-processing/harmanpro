class EmeaPage < ApplicationRecord
  extend FriendlyId
  friendly_id :title

  attr_accessor :linked_anchors
  has_many :resources, class_name: "EmeaPageResource", foreign_key: "emea_page_id", dependent: :destroy

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  after_initialize :set_defaults

  def self.for_top_nav(options={})
    items = where("position > 0").where("publish_on <= ?", Date.today)
    unless options[:include_employee_only_pages]
      items = items.where(employee_only: false)
    end
    items
  end

  def self.for_top_nav_for_employees
    where("position > 0").
      where("publish_on <= ?", Date.today).
      order(:position)
  end

  # EMEA Portal home page. We do this so we can use the /emea path
  def self.home
    if exists?('home')
      find('home')
    else
      new(title: "Home", content: "Home page not found. Please use the admin to create a page titled 'Home'.")
    end
  end

  def set_defaults
    self.highlight_color = "#006498" if highlight_color.blank?
  end

  def features
    resources.where(featured: true).order(Arel.sql('position'))
  end

  def published?
    publish_on.present? && publish_on <= Date.today
  end

  def is_home?
    title == "Home"
  end

  def has_anchors?
    anchors.size > 0
  end

  def anchors
    begin
      html = Nokogiri::HTML(self.content)
      html.css("a") - html.css("a[href]")
    rescue
      []
    end
  end

end
