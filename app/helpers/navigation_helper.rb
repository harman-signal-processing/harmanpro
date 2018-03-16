module NavigationHelper

  # Override contacts_path so locales can have different versions
  def contacts_path

    locale_path = current_locale.menu_items.where("title LIKE ?", I18n.t('nav.contacts'))
    if locale_path.exists?
      return locale_path.first.link
    end

    super
  end

end
