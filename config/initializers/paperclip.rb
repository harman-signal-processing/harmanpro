# monkeypatch to get around paperclip's horrible spoof detector
require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end

# Don't use the timestamp in the generated URLs
Paperclip::Attachment.default_options[:use_timestamp] = false

# Add support for timestamps in the stored file path
Paperclip.interpolates(:timestamp) do |attachment, style|
  attachment.instance_read(:updated_at).to_i
end

if Rails.env.test?

  Paperclip::Attachment.default_options.merge!({
    storage: :filesystem,
    url: '/system/:class/:attachment/:id_:timestamp/:basename.:extension',
    path: ":rails_root/spec/test_files/:class/:attachment/:id_:timestamp/:basename.:extension"
  })

  RESOURCES_STORAGE = {
    url: '/system/:class/:attachment/:id_:timestamp/:basename.:extension',
    path: ":rails_root/spec/test_files/:class/:attachment/:id_:timestamp/:basename.:extension"
  }

end

# Add this section after migrating the attachments
__END__
else

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
end
