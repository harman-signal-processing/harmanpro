ActiveAdmin.register Lead do
  menu parent: "LeadGen", label: "Leads", priority: 2
  actions :all, except: [:new, :create]
  permit_params :name, :company, :email, :phone, :project_description, :source, :location

  index do
    id_column
    column :contact_info do |lead|
      if lead.recipient_id.present?
        link_to lead.recipient_id, lead_path(id: lead.recipient_id), target: "_blank"
      elsif lead.email.present?
        if lead.name.present?
          mail_to lead.email, lead.name
        else
          mail_to lead.email, lead.email
        end
      end
    end
    column :created_at
    column :country
    actions
  end

  sidebar "Sensitive Data", only: [:index, :show] do
    content_tag(:p) do
      "Sensitive information is no longer stored here. Click through on the Acoustic Recipient field to view the data."
    end + content_tag(:p) do
      content_tag(:strong, "You'll need the login info:")
    end + content_tag(:ul) do
      content_tag(:li, "username: #{ENV['LEAD_VIEWER_NAME']}") +
      content_tag(:li, "password: #{ ENV['LEAD_VIEWER_PASSWORD']}")
    end
  end
  sidebar "Lead Recipients", only: [:index, :show] do
    content_tag(:p) do
      "Leads are sent to the corresponding sales person for the selected country. " +
        "Look for the Site Setting named 'leadgen-recipients' to configure who receives " +
        "the lead when no country recipients are found."
    end
  end

  show do
    if lead.recipient_id.present?
      attributes_table do
        row :acoustic_recipient do |lead|
          link_to lead.recipient_id, lead_path(id: lead.recipient_id), target: "_blank"
        end
        row :project_description
        row :country
        row :recipients
      end
    else
      default_main_content
    end
  end

  filter :country

end
