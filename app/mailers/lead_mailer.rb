class LeadMailer < ApplicationMailer
  default from: ENV['DEFAULT_SENDER']

  def new_lead(lead, locale=I18n.default_locale)
    @lead = lead

    Globalize.with_locale(locale) do
      tos = SiteSetting.value('leadgen-recipients').split(',')
      mail to: tos, subject: "New lead from pro.harman.com"
    end
  end
end
