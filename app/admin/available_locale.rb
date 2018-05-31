ActiveAdmin.register AvailableLocale do
  menu parent: "Settings", priority: 9

  permit_params :name, :key, :live, :show_hef

  # :nocov:
  index do
    selectable_column
    column :name
    column :key
    column :live
    actions
  end

  filter :name, as: :string

  form do |f|
    f.inputs do
      f.input :name
      f.input :key, as: :select, collection: I18n.available_locales.sort
      f.input :live
      f.input :show_hef, as: :boolean, label: "Show Harman Finance banners?"
    end
    f.actions
  end
  # :nocov:
end
