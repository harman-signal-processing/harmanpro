ActiveAdmin.register MediaOutlet do
  menu parent: "Media Coverage", priority: 3
  config.sort_order = 'name_asc'

  permit_params :name, :logo

  index do
    selectable_column
    column :name
    column "Coverage Count", :media_coverages do |media_outlet|
      media_outlet.media_coverages.length
    end
    actions
  end

  filter :name

  batch_action :merge do |ids|
    mos = MediaOutlet.where(id: ids)
      .left_joins(:media_coverages)
      .group(:id)
      .order("COUNT(media_coverages.id) DESC")
    if mos.length > 1
      keeper = mos.first
      MediaCoverage.where(media_outlet_id: ids).update_all(media_outlet_id: keeper.id)

      mos.where.not(id: keeper.id).destroy_all
      redirect_to admin_media_outlet_path(keeper), alert: "The media outlets were merged."
    else
      redirect_to collection_path, alert: "Select more than 1 to merge."
    end
  end

  show do
    attributes_table do
      row :name
      row :logo do
        if media_outlet.logo_file_name.present?
          link_to(media_outlet.logo.url(:original)) do
            image_tag(media_outlet.logo.url(:thumb))
          end
        else
          "(none)"
        end
      end
    end
    div do
      h3 "Media Coverage"
      table_for media_outlet.media_coverages.order("news_date DESC") do
        column :news_date
        column :headline do |media_coverage|
          link_to(media_coverage.headline, admin_media_coverage_path(media_coverage))
        end
        column :brands
      end
    end
  end

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :name
      f.input :logo, hint: f.object.logo.present? ?
        image_tag(f.object.logo.url(:thumb)) : ""
    end
    f.actions
  end
end
