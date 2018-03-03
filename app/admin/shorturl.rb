ActiveAdmin.register Shorturl do
  menu parent: "Settings"

  permit_params :shortcut, :full_url

  # :nocov:
  form do |f|
    f.inputs do
      f.input :shortcut, hint: "Usually just a one-word entry. Dashes and underscores are okay."
      f.input :full_url, hint: "Where should this short forward to?"
    end
    f.actions
  end
  # :nocov:

end
