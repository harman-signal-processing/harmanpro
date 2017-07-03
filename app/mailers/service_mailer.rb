class ServiceMailer < ActionMailer::Base

  def contact_form(contact_message, options={})
    @contact_message = contact_message
    @brand = contact_message.brand

    # Default recipient is brand's tech support
    recipient = @brand.tech_support_email
    recipient = @brand.parts_email if @contact_message.part_request?
    recipient = @brand.repair_email if @contact_message.repair_request?

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
      to: recipient,
      subject: "#{@contact_message.subject} (via pro.harman.com)",
      from: @contact_message.email
    )
  end

end
