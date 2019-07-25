ActiveAdmin.register AdminLog do
#   belongs_to :user
#   menu label: "AdminLog"
  menu parent: "Settings", priority: 11
  actions :all, except: [:new, :create, :edit, :destroy]
  
  index do
    id_column
    column "User" do |adminlog| 
        adminlog.user.email
    end
    column :action
    column :updated_at
    actions defaults: false do |adminlog|
      item "View", admin_admin_log_path(adminlog)
    end
  end  
  
#   filter :user
  filter :action
  
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
