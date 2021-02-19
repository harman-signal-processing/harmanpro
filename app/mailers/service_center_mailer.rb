class ServiceCenterMailer < ApplicationMailer
  default from: ENV['DEFAULT_SENDER']

  def registration(service_center)
    @service_center = service_center

    mail to: ENV['service_center_registration_recipient'],
      subject: "Service Center Registration"
  end
end
