ActiveAdmin.register BadActorLog do
  menu parent: "Settings", priority: 12
  actions :all, except: [:new, :create, :edit, :destroy]
end