class LeadMailer < ApplicationMailer
  default from: ENV['DEFAULT_SENDER']

  def new_lead(lead)
    @lead = lead

    mail to: lead.recipients, subject: "New lead from pro.harman.com"
  end
end
