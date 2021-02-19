class MediaLibraryMailer < ApplicationMailer
  default from: ENV['DEFAULT_SENDER']

  def access_request(media_library_access_request)
    @media_library_access_request = media_library_access_request

    tos = SiteSetting.value('media-library-recipients').split(',')
    mail to: tos, subject: "DAM access request"
  end
end
