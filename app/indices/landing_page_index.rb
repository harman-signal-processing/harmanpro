ThinkingSphinx::Index.define :landing_page, name: "landing_page_en", with: :active_record do

  indexes translations.title
  indexes translations.main_content
  indexes translations.left_content
  indexes translations.right_content
  indexes translations.sub_content
  indexes translations.description

  where "landing_page_translations.locale = 'en'"
end
