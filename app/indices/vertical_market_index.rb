ThinkingSphinx::Index.define :vertical_market, name: "vertical_market_en", with: :active_record do

  indexes translations.headline
  indexes translations.description
  indexes translations.name
  indexes translations.extra_content

  where "vertical_market_translations.locale = 'en'"
  where sanitize_sql(["live", true])

end

