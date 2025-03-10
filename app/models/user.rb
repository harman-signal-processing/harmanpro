class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :two_factor_backupable
  
  devise :two_factor_authenticatable, :registerable, :recoverable,
    :validatable, :trackable, :rememberable
  
  has_many :locale_translators, dependent: :destroy, inverse_of: :translator
  has_many :locales, through: :locale_translators
  has_many :country_lead_recipients, inverse_of: :user
  has_many :admin_logs

  accepts_nested_attributes_for :locale_translators, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :country_lead_recipients, reject_if: :all_blank, allow_destroy: true

  validate :invitation_code_is_valid, on: :create, if: :needs_invitation_code?
  attr_accessor :invitation_code

  before_create :set_initial_role

  ROLES = %w[
    admin
    translator
    emea_distributor
    emea_admin
    tse_admin
    contact_admin
    super_admin
    service_department
    lead_recipient
    pr_admin
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
    !(roles.size > 0)
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
    super_admin? || admin? || service_department? || pr_admin?
  end

  # EMEA access
  def emea_access?
    emea_distributor? || emea_admin_access?
  end

  # EMEA admin access
  def emea_admin_access?
    emea_admin? || admin?
  end

  def tse_admin_access?
    tse_admin? || admin?
  end

  def contact_admin_access?
    contact_admin? || admin?
  end

  def pr_admin_access?
    pr_admin? || admin?
  end

  def is_employee?
    !!(email.to_s.match(/\@harman\.com$/i))
  end

  def roles
    ROLES.reject{|r| !(eval "self.#{r}")}
  end

  def name
    email
  end
  
end
