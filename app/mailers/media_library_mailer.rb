class MediaLibraryMailer < ApplicationMailer

  def access_request(media_library_access_request)
    @media_library_access_request = media_library_access_request

    tos = SiteSetting.value('media-library-recipients').split(',')
    from = SiteSetting.value('media-library-sender') || "noreply@harmanpro.com"
    mail to: tos,
      from: from,
      subject: "DAM access request"
  end
end
