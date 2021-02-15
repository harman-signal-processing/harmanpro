class Lead < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  belongs_to :vertical_market # (maybe)

  after_create :notify_leadgen_recipients, :subscribe!
  attr_accessor :locale
  attr_accessor :recipient_id
  attr_accessor :columns

  def subscribe!
    begin
      name_fields = name.split(/\s/)
      user_params = {
        email: email,
        :"BR_HPro" => true,
        :"First Name" => name_fields.first,
        :"Last Name" => name_fields.last,
        :country => location,
        :company => company,
        :phone => phone
      }
      Lead.goacoustic_client.add_recipient(user_params, ENV['ACOUSTIC_DB_ID'], [ENV['ACOUSTIC_LIST_ID']])
    rescue
      logger.debug("There was some acoustic exception")
    end
  end
  handle_asynchronously :subscribe!

  def notify_leadgen_recipients
    LeadMailer.new_lead(self, self.locale.to_s).deliver_later
  end

  # Gets subscriber data from goacoustic
  def self.retrieve_remote(recipient_id)
    lead_data = goacoustic_client.get_recipient(ENV['ACOUSTIC_DB_ID'], recipient_id)
    if lead_data.SUCCESS == "TRUE"
      Lead.new(
        recipient_id: recipient_id,
        email: lead_data.Email,
        columns: Hash[lead_data.COLUMNS.COLUMN.collect{|c| [c.NAME.to_sym, c.VALUE] }]
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
