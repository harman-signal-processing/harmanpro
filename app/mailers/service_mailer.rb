class ServiceMailer < ActionMailer::Base
  default from: ENV['DEFAULT_SENDER']

  def contact_form(contact_message, options={})
    @contact_message = contact_message

    if contact_message.attachment.present?
      begin
        attachments[contact_message.attachment_file_name] = {
          mime_type: contact_message.attachment_content_type,
          content: open(contact_message.attachment.url).read
        }
      rescue OpenURI::HTTPError
        logger.debug("Mail was sent before attachment arrived at file store.")
        attachments[contact_message.attachment_file_name] = nil
      end
    end

    mail(
      to: @contact_message.recipient,
      subject: "#{@contact_message.subject} (via pro.harman.com)"
    )
  end

end
