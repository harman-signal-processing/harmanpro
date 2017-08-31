AvailableLocale.live.each do |locale|
  locale_underscored = locale.to_s.gsub(/\-/, "_")

  ThinkingSphinx::Index.define :landing_page, name: "landing_page_#{locale_underscored}", with: :active_record do

    indexes translations.title
    indexes translations.main_content
    indexes translations.left_content
    indexes translations.right_content
    indexes translations.sub_content
    indexes translations.description

    where "landing_page_translations.locale = '#{locale}'"
  end
end
