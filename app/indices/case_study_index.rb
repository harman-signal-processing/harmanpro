AvailableLocale.live.each do |locale|
  locale_underscored = locale.to_s.gsub(/\-/, "_")

  ThinkingSphinx::Index.define :case_study, name: "case_study_#{locale_underscored}", with: :active_record do

    indexes translations.headline
    indexes translations.description
    indexes translations.content

    where "case_study_translations.locale = '#{locale}'"
  end
end
