ActiveAdmin.register ContactMessage do
  menu label: "Support Messages", parent: "Service"
  actions :index, :show, :destroy

  # :nocov:
  index do
    selectable_column
    column :name
    column :email
    column :message_type
    column :brand
    column :product
    actions
  end
  # :nocov:

  filter :brand
  filter :product
  filter :message_type
  filter :created_at

  show do
    attributes_table do
      row :name
      row :email
      row :subject
      row :brand
      row :product

      if contact_message.part_request? || contact_message.repair_request?
        row :company
        row :account_number
        row :shipping_address do
          raw("#{contact_message.shipping_address}<br>" +
          "#{contact_message.shipping_city} " +
          "#{contact_message.shipping_state} " +
          "#{contact_message.shipping_zip}")
        end
        row :billing_address do
          raw("#{contact_message.billing_address}<br>" +
          "#{contact_message.billing_city} " +
          "#{contact_message.billing_state} " +
          "#{contact_message.billing_zip}")
        end
      end

      if contact_message.part_request?
        row :part_number
      end

      if contact_message.repair_request?
        row :product_serial_number
        row :warranty
        row :purchased_on
      end

      if contact_message.support?
        row :product_serial_number
        row :operating_system
        row :country do
          ISO3166::Country[contact_message.shipping_country].name
        end
      end

      row :message

      if contact_message.attachment.present?
        row :attachment do
          link_to(contact_message.attachment_file_name,
                  contact_message.attachment.url)
        end
      end

    end
  end

  csv do
    column :id
    column :name
    column :email
    column :subject
    column :message
    column :product
    column :operating_system
    column :message_type
    column :company
    column :account_number
    column :phone
    column :fax
    column :billing_address
    column :billing_city
    column :billing_state
    column :billing_zip
    column :shipping_address
    column :shipping_city
    column :shipping_state
    column :shipping_zip
    column :product_sku
    column :product_serial_number
    column :warranty
    column :purchased_on
    column :part_number
    column :board_location
    column :shipping_country
    column :created_at
    column :updated_at
    column :attachment_file_name
    column :attachment_content_type
    column :attachment_file_size
    column :attachment_updated_at
    column(:brand) { |contact_message| contact_message.brand.name }
  end
end
