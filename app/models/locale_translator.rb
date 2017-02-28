class LocaleTranslator < ApplicationRecord
  belongs_to :locale, class_name: 'AvailableLocale', foreign_key: :available_locale_id
  belongs_to :translator, class_name: 'AdminUser', foreign_key: :admin_user_id

  validates :locale, presence: true
  validates :translator, presence: true, uniqueness: { scope: :locale }
end
