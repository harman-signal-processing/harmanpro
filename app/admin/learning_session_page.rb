ActiveAdmin.register LearningSessionPage do
  menu parent: "Learning Sessions", priority: 2
  permit_params :body, :custom_css, :brand_id

  index do
    column :brand do |page|
      page.brand.name
    end
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :brand, collection: Brand.order(Arel.sql("UPPER(name)"))
      f.input :body, as: :text, input_html: { class: "mceEditor"}
      f.input :custom_css, as: :text
    end  #  f.inputs do
    f.actions
  end  #  form do |f|
end  #  ActiveAdmin.register LearningSessionPage do