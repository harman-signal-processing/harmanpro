ActiveAdmin.register SiteSetting do
  menu parent: "Settings", priority: 1

  permit_params :name, :content

  # :nocov:
  index do
    selectable_column
    column :name
    column :content do |s|
      raw(textilize(s.content))
    end
    actions
  end

  filter :name, as: :string

  show do
    attributes_table do
      row :name

      row :content do
        raw(textilize(site_setting.content))
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :content, as: :text
    end
    f.actions
  end
  # :nocov:

  # Weird place for this, I know
  collection_action :flush_cache, method: :get do
    if Rails.env.production? && RAILS_ENV['REDIS_URL'].present?
      res = Redis.new(url: RAILS_ENV['REDIS_URL']).flushall
      notice = "Redis cache is being flushed now. Response: #{res}"
    else
      notice = "Flushing cache only works in production."
    end
    redirect_to admin_dashboard_path, notice: notice
  end
end
