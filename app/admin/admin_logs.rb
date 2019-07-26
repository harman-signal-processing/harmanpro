ActiveAdmin.register AdminLog do
  menu parent: "Settings", priority: 11
  actions :all, except: [:new, :create, :edit, :destroy]
  
  index do
    id_column
    column "User" do |adminlog| 
        adminlog.user.email
    end
    column :action
    column :updated_at do |adminlog|
      # Time.parse(adminlog.updated_at).in_time_zone("Central Time (US & Canada)")
      adminlog.updated_at.strftime("%A %-m/%-d/%y %I:%M %p")
    end
    actions defaults: false do |adminlog|
      item "View", admin_admin_log_path(adminlog)
    end
  end  
  
  filter :action
  filter :updated_at
  
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
