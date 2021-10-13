ActiveAdmin.register LearningSessionEvent do
  menu parent: "Learning Sessions", priority: 1

  permit_params :title, :subtitle, :description,
    learning_session_event_sessions_attributes: [:id, :title, :session_date, :session_times, :register_link, :_destroy],
    learning_session_event_brands_attributes: [:id, :brand_id, :_destroy]

  filter :title
  filter :subtitle
  filter :description
  filter :brands, collection: -> { Brand.with_learning_session_events }

  index do
    column :title
    column :subtitle
    column :sessions do |item|
      ul do
        item.learning_session_event_sessions.each do |v|
          s = "<p>#{v.title}<br \>#{v.session_date.strftime "%A, %b %d, %Y"}<br \>#{v.session_times}<br \><br \></p>"
          li div raw(s)
        end  #  item.learning_session_event_sessions.each do |v|
      end  #  ul do

    end
    column :brands do |c|
      c.brands.map do |v|
        v.name
      end.join(', ')
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :subtitle
      f.input :description, as: :text, input_html: { class: "mceEditor"}
      f.has_many :learning_session_event_sessions, heading: "Sessions", new_record: "Add a session" do |s|
        s.input :id, as: :hidden
        s.input :title, label: "Session Title"
        s.input :session_date, label: "Session Date",  as: :datepicker
        s.input :session_times, label: "Session Times"
        s.input :register_link, label: "Registration Link"
      end  #  f.has_many :learning_session_event_sessions, heading: "Sessions", new_record: "Add a session" do |s

      f.has_many :learning_session_event_brands, heading: "Related Brands", new_record: "Add a related brand" do |s|
        s.input :id, as: :hidden
        s.input :brand, collection: Brand.order(Arel.sql("UPPER(name)"))
        s.input :_destroy, as: :boolean, label: "Delete"
      end
    end  #  f.inputs do
    f.actions
  end  #  form do |f|

end  #  ActiveAdmin.register LearningSessionEvent do