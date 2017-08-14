class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :locale_translators, dependent: :destroy, inverse_of: :translator
  has_many :locales, through: :locale_translators

  accepts_nested_attributes_for :locale_translators, reject_if: :all_blank, allow_destroy: true

  def locales_to_translate
    @locales_to_translate ||= locales
  end

  def translatable_locales
    @translatable_locales ||= locales - [AvailableLocale.default]
  end

  # The CMS user could be multiple roles
  def cms_user?
    super_admin? || admin? || translator? || service_department?
  end

  # Access to ActiveAdmin for several roles
  def admin_access?
    super_admin? || admin? || service_department?
  end
end
