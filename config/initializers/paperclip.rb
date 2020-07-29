# monkeypatch to get around paperclip's horrible spoof detector
require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
  class UrlGenerator
    private
    def escape_url(url)
      if url.respond_to?(:escape)
        url.escape
      else
        url.gsub(escape_regex){|m| "%#{m.ord.to_s(16).upcase}" }
      end
    end
  end
end

Paperclip::Attachment.default_options[:compression] = {
  png: "-o 5 -quiet",
  jpeg: "-copy none -optimize -progressive"
}

# Don't use the timestamp in the generated URLs
Paperclip::Attachment.default_options[:use_timestamp] = false

# Add support for timestamps in the stored file path
Paperclip.interpolates(:timestamp) do |attachment, style|
  attachment.instance_read(:updated_at).to_i
end

if Rails.env.production? || !!(ENV['USE_PRODUCTION_ASSETS'].to_i > 0)

	Paperclip::Attachment.default_options.merge!({
    url: ':fog_public_url',
    path: ":class/:attachment/:id_:timestamp/:basename_:style.:extension",
    storage: :fog,
    fog_credentials: {
      provider:           'Rackspace',
      rackspace_username: ENV['RACKSPACE_USERNAME'],
      rackspace_api_key:  ENV['RACKSPACE_API_KEY'],
      rackspace_region:   :ord
    },
    fog_directory: ENV['FOG_PAPERCLIP_CONTAINER'],
    fog_public: true,
    fog_host: ENV['FOG_HOST_ALIAS']
	})

  RESOURCES_STORAGE = {
    url: '/system/:class/:attachment/:id_:timestamp/:basename.:extension',
    path: ":rails_root/public/system/:class/:attachment/:id_:timestamp/:basename.:extension"
  }

elsif Rails.env.test?

  Paperclip::Attachment.default_options.merge!({
    storage: :filesystem,
    url: '/system/:class/:attachment/:id_:timestamp/:basename.:extension',
    path: ":rails_root/spec/test_files/:class/:attachment/:id_:timestamp/:basename.:extension"
  })

  RESOURCES_STORAGE = {
    url: '/system/:class/:attachment/:id_:timestamp/:basename.:extension',
    path: ":rails_root/spec/test_files/:class/:attachment/:id_:timestamp/:basename.:extension"
  }

else

	Paperclip::Attachment.default_options.merge!({
    url: '/system/:class/:attachment/:id_:timestamp/:basename_:style.:extension',
    storage: :filesystem,
    path: ":rails_root/public/system/:class/:attachment/:id_:timestamp/:basename_:style.:extension"
	})

  RESOURCES_STORAGE = {
    url: '/system/:class/:attachment/:id_:timestamp/:basename.:extension',
    storage: :filesystem,
    path: ":rails_root/public/system/:class/:attachment/:id_:timestamp/:basename.:extension"
  }

end
