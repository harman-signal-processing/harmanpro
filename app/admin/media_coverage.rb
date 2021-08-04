ActiveAdmin.register MediaCoverage do
  menu parent: "Media Coverage", priority: 1
  config.sort_order = 'news_date_desc'

  permit_params :news_date,
    :media_outlet_id,
    :headline,
    :description,
    :media_type,
    :syndicated,
    :media_length,
    :case_study,
    :initiative,
    :region,
    :link,
    brand_media_coverages_attributes: [:id, :brand_id, :_destroy]


  index do
    selectable_column
    column :news_date
    column :headline
    column :media_outlet
    column :brands do |c|
      c.brands.map do |v|
        v.name
      end.join(', ')
    end
    actions
  end


  filter :headline
  filter :brands, as: :select
  filter :media_outlet
  filter :initiative
  filter :media_type, as: :select
  filter :media_length
  filter :syndicated
  filter :case_study, as: :boolean
  filter :region, as: :select


  show do
    attributes_table do
      row :headline
      row :description
      row :news_date
      row :media_outlet
      row :link do |mc|
        link_to mc.link, mc.link, target: "_blank"
      end
      row :media_type
      row :syndicated
      row :media_length
      row :case_study
      row :initiative
      row :region
      row :brands
    end
  end

  form do |f|
    f.inputs do
      f.input :headline
      f.input :link
      f.input :description, hint: "Appears below the headline."
      f.input :media_outlet, collection: MediaOutlet.order("name")
      f.input :news_date, as: :datepicker
      f.input :media_type
      f.input :syndicated, as: :radio
      f.input :media_length
      f.input :case_study, as: :radio
      f.input :initiative
      f.input :region
    end
    f.has_many :brand_media_coverages, heading: "Related Brands", new_record: "Add a related brand" do |s|
      s.input :id, as: :hidden
      s.input :brand, collection: Brand.order(Arel.sql("UPPER(name)"))
      s.input :_destroy, as: :boolean, label: "Delete"
    end
    f.actions
  end

end
