class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :locale_translators, dependent: :destroy, inverse_of: :translator
  has_many :locales, through: :locale_translators

  accepts_nested_attributes_for :locale_translators, reject_if: :all_blank, allow_destroy: true

  validate :invitation_code_is_valid, on: :create, if: :needs_invitation_code?
  attr_accessor :invitation_code

  before_create :set_initial_role

  ROLES = %w[
    admin
    translator
    emea_distributor
    emea_admin
    super_admin
    service_department
  ]

  def invitation_code_is_valid
    if invitation_code.blank?
      errors.add(:invitation_code, "cannot be blank.")
    end
    unless SiteSetting.invitation_codes.include?(invitation_code)
      errors.add(:invitation_code, "is invalid. (it is cAsE sEnSiTiVe.)")
    end
  end

  # If the user was created with at least one role defined,
  # then it was created using the Admin tool and doesn't need to
  # rely on an invitation code.
  def needs_invitation_code?
    !(roles.length > 0)
  end

  def set_initial_role
    if invitation_code.present?
      if role = SiteSetting.role_from_invitation_code(invitation_code)
        self.send("#{role}=".to_sym, true)
      end
    end
  end

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

  # EMEA access
  def emea_access?
    emea_distributor? || emea_admin? || admin?
  end

  def roles
    ROLES.reject{|r| !(eval "self.#{r}")}
  end

end
