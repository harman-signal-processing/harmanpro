class LeadMailer < ApplicationMailer

  def new_lead(lead, locale=I18n.default_locale)
    @lead = lead

    Globalize.with_locale(locale) do
      tos = SiteSetting.value('leadgen-recipients').split(',')
      from = SiteSetting.value('leadgen-sender') || "leadgen@harman.com"
      mail to: tos,
        from: from,
        subject: "New lead from pro.harman.com"
    end
  end
end
