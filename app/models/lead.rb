class Lead < ApplicationRecord
  validates :name, presence: true, on: :create
  validates :email, presence: true, on: :create
  validates :country, presence: true
  validates :company, exclusion: { in: ["Example"] }
  validates :phone, exclusion: { in: ["123-456-7890"] }
  belongs_to :vertical_market # (maybe)

  after_create :send_to_acoustic!
  before_update :notify_leadgen_recipients, :erase_personal_data
  attr_accessor :locale
  attr_accessor :columns

  def send_to_acoustic
    res = Lead.goacoustic_client.add_recipient(acoustic_user_params, ENV['ACOUSTIC_DB_ID'], [ENV['ACOUSTIC_LIST_ID']])
    res = res.Envelope.Body
    if res.RESULT.SUCCESS == "TRUE"
      # set the recipient_id and erase personal data (keep country and project description)
      if res.RESULT.RecipientId.present?
        self.recipient_id = res.RESULT.RecipientId
        save
      else
        logger.debug("Acoustic did not return recipient ID")
      end
    elsif res.Fault.FaultString.to_s.match?(/Already Exists/i)
      logger.debug("Acoustic recipient already exists.")
      get_acoustic_recipient
    end
  end

  def send_to_acoustic!
    begin
      send_to_acoustic
    rescue
      logger.debug("There was some acoustic exception")
    end
  end
  handle_asynchronously :send_to_acoustic!

  def get_acoustic_recipient
    res = Lead.goacoustic_client.get_recipient({email: email}, ENV['ACOUSTIC_DB_ID'])
    if res.SUCCESS?
      # set the recipient_id and erase personal data (keep country and project description)
      if res.RecipientId.present?
        self.recipient_id = res.RecipientId
        save
      else
        logger.debug("Acoustic did not return recipient ID")
      end
    end
  end

  def acoustic_subscription_field
    case self.source
    when /jbl/i
      "0523_SUB_Product Updates News and Events from JBL Professional_HARMAN Professional Solutions"
    else
      "0525_SUB_Product Updates News and Events from HARMAN Professional Solutions and Brands _Open to Public"
    end
  end

  def acoustic_user_params
    name_fields = name.split(/\s/)
    {
      email: email,
      :"0000_Source" => "pro.harman.com Leadgen form #{source}",
      :"0001_First_Name" => name_fields.first,
      :"0002_Last_Name" => name_fields.last,
      :"0003_Phone_Number" => phone,
      :"0004_Company" => company,
      :"0008_City" => city,
      :"0009_State_Province" => state,
      :"00a11_Country_Custom" => country_name,
      :"0012a_Project_Details" => project_description,
      :"#{acoustic_subscription_field}" => !!subscribe?
    }
  end

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

  # Gets subscriber data from goacoustic
  def self.retrieve_remote(recipient_id)
    lead_data = goacoustic_client.get_recipient({}, ENV['ACOUSTIC_DB_ID'], recipient_id)
    if lead_data.SUCCESS == "TRUE"
      columns = Hash[lead_data.COLUMNS.COLUMN.collect{|c| [c.NAME.to_sym, c.VALUE] }]
      Lead.new(
        recipient_id: recipient_id,
        email: lead_data.Email,
        name: "#{columns[:'0001_First_Name']} #{columns[:'0002_Last_Name']}",
        phone: columns[:'0003_Phone_Number'],
        company: columns[:'0004_Company'],
        project_description: columns[:"0012a_Project_Details"],
        country: columns[:"00a11_Country_Custom"],
        columns: columns
      )
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def lead_followups
    if self.recipient_id.present?
      LeadFollowup.where(recipient_id: self.recipient_id)
    else
      []
    end
  end

  private

  def self.goacoustic_client
    @goacoustic_client ||= GoAcoustic.new(access_token: goacoustic_access_token.token, url: ENV['ACOUSTIC_API_URL'])
  end

  def self.goacoustic_access_token
    client = OAuth2::Client.new(ENV['ACOUSTIC_CLIENT_ID'],
                                ENV['ACOUSTIC_CLIENT_SECRET'],
                                site: "#{ENV['ACOUSTIC_API_URL']}/oauth/token")
    @goacoustic_access_token ||= OAuth2::AccessToken.from_hash(client, refresh_token: ENV['ACOUSTIC_REFRESH_TOKEN']).refresh!
  end

end
