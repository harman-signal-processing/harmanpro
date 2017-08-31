AvailableLocale.live.each do |locale|
  locale_underscored = locale.to_s.gsub(/\-/, "_")

  ThinkingSphinx::Index.define :vertical_market, name: "vertical_market_#{locale_underscored}", with: :active_record do

    indexes translations.headline
    indexes translations.description
    indexes translations.name
    indexes translations.extra_content

    where "vertical_market_translations.locale = '#{locale}'"
    where sanitize_sql(["live", true])

  end
end
