ActiveAdmin.register LearningSessionFeaturedVideo do
  menu parent: "Learning Sessions", priority: 3
  permit_params :title, :youtube_id, :brand_id, :position

  form do |f|
    f.inputs do
      f.input :title
      f.input :youtube_id

      f.input :brand, collection: Brand.order(Arel.sql("UPPER(name)"))
      f.input :position
    end  #  f.inputs do
    f.actions
  end  #  form do |f|
end  #  ActiveAdmin.register LearningSessionFeaturedVideo do