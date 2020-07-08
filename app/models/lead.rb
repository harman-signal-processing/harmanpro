class Lead < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  belongs_to :vertical_market # (maybe)

  after_create :notify_leadgen_recipients, :subscribe!
  attr_accessor :locale

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
      goacoustic_client.add_recipient(user_params, ENV['ACOUSTIC_DB_ID'], [ENV['ACOUSTIC_LIST_ID']])
    rescue
      logger.debug("There was some acoustic exception")
    end
  end
  handle_asynchronously :subscribe!

  def notify_leadgen_recipients
    LeadMailer.new_lead(self, self.locale.to_s).deliver_later
  end

  private

  def goacoustic_client
    @goacoustic_client ||= GoAcoustic.new(access_token: acoustic_access_token.token, url: ENV['ACOUSTIC_API_URL'])
  end

  def goacoustic_access_token
    client = OAuth2::Client.new(ENV['ACOUSTIC_CLIENT_ID'],
                                ENV['ACOUSTIC_CLIENT_SECRET'],
                                site: "#{ENV['ACOUSTIC_API_URL']}/oauth/token")
    @goacoustic_access_token ||= OAuth2::AccessToken.from_hash(client, refresh_token: ENV['ACOUSTIC_REFRESH_TOKEN']).refresh!
  end

end
