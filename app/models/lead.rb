class Lead < ActiveRecord::Base
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
      silverpop_client.add_recipient(user_params, ENV['SILVERPOP_DB_ID'], [ENV['SILVERPOP_LIST_ID']])
    rescue
      logger.debug("There was some silverpop exception")
    end
  end
  handle_asynchronously :subscribe!

  def notify_leadgen_recipients
    LeadMailer.new_lead(self, self.locale.to_s).deliver_later
  end

  private

  def silverpop_client
    @silverpop_client ||= SilverPop.new(access_token: silverpop_access_token.token, url: ENV['SILVERPOP_API_URL'])
  end

  def silverpop_access_token
    client = OAuth2::Client.new(ENV['SILVERPOP_CLIENT_ID'],
                                ENV['SILVERPOP_CLIENT_SECRET'],
                                site: "#{ENV['SILVERPOP_API_URL']}/oauth/token")
    @silverpop_access_token ||= OAuth2::AccessToken.from_hash(client, refresh_token: ENV['SILVERPOP_REFRESH_TOKEN']).refresh!
  end

end
