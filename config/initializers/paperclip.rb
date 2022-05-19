# monkeypatch to get around paperclip's horrible spoof detector
require 'paperclip/media_type_spoof_detector'
require 'addressable'
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
        Addressable::URI.parse(url).normalize.to_str.gsub(escape_regex){|m| "%#{m.ord.to_s(16).upcase}" }
      end
    end
  end
end

Paperclip::UriAdapter.register
Paperclip::HttpUrlProxyAdapter.register

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

# Amazon account 'hspwww' access keys:
c = YAML.load_file(File.join(Rails.root, 'config/s3.yml')).symbolize_keys
if Rails.env.production? || !!(ENV['USE_PRODUCTION_ASSETS'].to_i > 0)
  paperclip_env = :production
else
  paperclip_env = Rails.env.to_sym
end
Rails.configuration.aws = c[paperclip_env].symbolize_keys!

#Aws.config(logger: Rails.logger)
#Aws.config(Rails.configuration.aws)

# Cloudfront only seems to work with an S3 bucket OR some other source (not both).
# So, since cdn.harmanpro.com is setup as an alias of assets.harmanpro.com, we need
# a separate CDN for stuff in the S3 buckets...
S3_CLOUDFRONT = "d3nw26meo6dlp6.cloudfront.net" #"#{Rails.configuration.aws[:bucket]}.s3.amazonaws.com"

if Rails.env.production? || !!(ENV['USE_PRODUCTION_ASSETS'].to_i > 0)

  S3_STORAGE = {
    storage: :s3,
    bucket: Rails.configuration.aws[:bucket],
    s3_credentials: Rails.configuration.aws,
    s3_host_alias: S3_CLOUDFRONT,
    s3_protocol: 'https',
    s3_region: Rails.configuration.aws[:region],
    url: ':s3_alias_url',
    path: ":class/:attachment/:id_:timestamp/:basename_:style.:extension"
  }
  
	Paperclip::Attachment.default_options.merge!(S3_STORAGE)
	
	RESOURCES_STORAGE = S3_STORAGE.merge({
    path: ":class/:attachment/:id_:timestamp/:basename.:extension"
  })
  
elsif Rails.env.test?

  Paperclip::Attachment.default_options.merge!({
    storage: :filesystem,
    url: '/system/:class/:attachment/:id_:timestamp/:basename.:extension',
    path: ":rails_root/spec/test_files/:class/:attachment/:id_:timestamp/:basename.:extension"
  })

  S3_STORAGE = {
    url: '/system/:class/:attachment/:id_:timestamp/:basename.:extension',
    path: ":rails_root/spec/test_files/:class/:attachment/:id_:timestamp/:basename.:extension"
  }

	RESOURCES_STORAGE = {
    url: '/system/:class/:attachment/:id_:timestamp/:basename.:extension',
    path: ":rails_root/public/system/:class/:attachment/:id_:timestamp/:basename.:extension"
  }
else

	Paperclip::Attachment.default_options.merge!({
    url: '/system/:class/:attachment/:id_:timestamp/:basename_:style.:extension',
    storage: :filesystem,
    path: ":rails_root/public/system/:class/:attachment/:id_:timestamp/:basename_:style.:extension"
	})

  S3_STORAGE = {
    url: '/system/:class/:attachment/:id_:timestamp/:basename.:extension',
    path: ":rails_root/spec/test_files/:class/:attachment/:id_:timestamp/:basename.:extension"
  }

	RESOURCES_STORAGE = {
    url: '/system/:class/:attachment/:id_:timestamp/:basename.:extension',
    path: ":rails_root/public/system/:class/:attachment/:id_:timestamp/:basename.:extension"
  }
end
