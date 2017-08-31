ThinkingSphinx::Index.define :case_study, name: "case_study_en", with: :active_record do

  indexes translations.headline
  indexes translations.description
  indexes translations.content

  where "case_study_translations.locale = 'en'"
end

ThinkingSphinx::Index.define :case_study, name: "case_study_zh", with: :active_record do

  indexes translations.headline
  indexes translations.description
  indexes translations.content

  where "case_study_translations.locale = 'zh'"
end
