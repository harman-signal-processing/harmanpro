class ServiceMailer < ActionMailer::Base

  def contact_form(contact_message, options={})
    @contact_message = contact_message
    @brand = contact_message.brand

    # Default recipient is brand's tech support
    recipient = @brand.tech_support_email
    recipient = @brand.parts_email if @contact_message.part_request?
    recipient = @brand.repair_email if @contact_message.repair_request?

    mail(
      to: recipient,
      subject: "#{@contact_message.subject} (via pro.harman.com)",
      from: @contact_message.email
    )
  end

end
