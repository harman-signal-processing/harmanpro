class MenuItem < ApplicationRecord
  belongs_to :locale, class_name: "AvailableLocale", touch: true, optional: true

  validates :title, presence: true
  validates :link, presence: true

  after_initialize :set_defaults

  def set_defaults
    locale ||= AvailableLocale.where(key: I18n.default_locale, name: "English").first_or_initialize
  end

  def name
    title
  end
end
