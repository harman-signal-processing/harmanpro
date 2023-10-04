class Lead < ApplicationRecord
  validates :name, presence: true, on: :create
  validates :email, presence: true, on: :create
  validates :country, presence: true
  validates :company, exclusion: { in: ["Example"] }
  validates :phone, exclusion: { in: ["123-456-7890"] }
  belongs_to :vertical_market, optional: true

  before_update :notify_leadgen_recipients, :erase_personal_data
  attr_accessor :locale
  attr_accessor :columns

  def country_name
    if c = ISO3166::Country.new(country)
      c.iso_short_name
    else
      country
    end
  end

  def notify_leadgen_recipients
    if recipient_id_was.blank? && recipient_id.present?
      LeadMailer.new_lead(self).deliver_later
    end
  end

  # Do this after sending lead data to CMS or ESP
  def erase_personal_data
    if recipient_id.present?
      self.name = nil
      self.email = nil
      self.phone = nil
      self.city = nil
      self.state = nil
      self.company = nil
    end
  end

  def country_lead_recipients
    CountryLeadRecipient.where(country: country).includes(:user)
  end

  def recipients
    if source.to_s.match?(/axys/)
      ["tunnel@harman.com"]
    elsif country_lead_recipients.size > 0
      country_lead_recipients.map{|clr| clr.user.email }
    else
      Globalize.with_locale(locale.to_s) do
        SiteSetting.value('leadgen-recipients').split(',')
      end
    end
  end

  def lead_followups
    if self.recipient_id.present?
      LeadFollowup.where(recipient_id: self.recipient_id)
    else
      []
    end
  end

end
