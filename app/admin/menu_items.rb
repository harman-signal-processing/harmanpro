ActiveAdmin.register MenuItem do
  menu parent: "Settings", name: "Resources Menu", priority: 5

  permit_params :title, :link, :position, :locale_id, :top_nav_name, :new_tab

  index do
    selectable_column
    id_column
    column :title
    column :link
    column :position
    column :locale
    column :top_nav_name
    actions
  end

  sidebar "Instructions" do
    "These links are used for customizing the 'Resources' menu only. Leave the locale blank when creating default menu items."
  end

  filter :locale
  filter :title
  filter :top_nav_name

  form do |f|
    f.inputs do
      f.input :title, hint: "Link text"
      f.input :link
      f.input :new_tab
      f.input :position, hint: "Sorting order among other menu items of the same locale."
      f.input :locale, hint: "Leave blank when editing the default menu"
      f.input :top_nav_name, hint: "This is the top nav parent name"
    end
    f.actions
  end

end
