class AddShowHefToAvailableLocales < ActiveRecord::Migration[5.1]
  def change
    add_column :available_locales, :show_hef, :boolean, default: true

    AvailableLocale.where("name LIKE '%russia%'").update_all(show_hef: false)
  end
end
