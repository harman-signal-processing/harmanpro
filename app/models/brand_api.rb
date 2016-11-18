class BrandApi
  include HTTParty

  format :json

  def self.software(url)
    get_api_response(url, 12.hours)
  end

  def self.product(url)
    get_api_response(url, 6.hours)
  end

  def self.products(url)
    get_api_response(url, 8.hours)
  end

  def self.info(url)
    get_api_response(url, 8.hours)
  end

  private

  # :nocov:
  def self.get_api_response(url, cache_for)
    Rails.cache.fetch(url, expires_in: cache_for, race_condition_ttl: 10) do
      response = get(url)
      if response.success?
        response.parsed_response
      else
        raise response.message
      end
    end
  end
  # :nocov:

end
