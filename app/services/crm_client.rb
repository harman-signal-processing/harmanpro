require 'httparty'

class CrmClient
  attr_accessor :service_url, :api_secret, :sending_host
  
  def initialize(opts={})
    @service_url  = opts[:service_url] || ENV['CRM_SERVICE_URL']
    @api_secret   = opts[:api_secret] || ENV['CRM_API_SECRET']
    @sending_host = opts[:sending_host] || ENV['CRM_CLIENT_HOSTNAME']
  end
  
  def add_lead(lead)
    HTTParty.post(
      URI.encode(service_url),
      headers: {
        'Content-Type' => 'application/json',
        'User-Agent' => 'HARMAN Professional Website',
        ImmutableKey.new('mw-sending-host') => sending_host,
        ImmutableKey.new('mw-sending-host-thumbprint') => api_secret
      },
      #debug_output: Rails.logger,
      body: lead.to_crm_json
    )
  end
    
end