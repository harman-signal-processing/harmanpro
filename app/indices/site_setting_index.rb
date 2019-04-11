AvailableLocale.live.each do |locale|
  locale_underscored = locale.to_s.gsub(/\-/, "_")

  ThinkingSphinx::Index.define :site_setting, name: "site_setting_#{locale_underscored}", with: :active_record do
    indexes translations.content, :as => :consultant_content
    where "site_setting_translations.locale = '#{locale}' and site_settings.name in ('consultant-portal-welcome-paragraph', 'consultant-portal-contacts')"
  end  #  ThinkingSphinx::Index.define :site_setting, name: "site_setting_#{locale_underscored}", with: :active_record do
end  #  AvailableLocale.live.each do |locale|