class CreateContactMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_messages do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :message
      t.string :product
      t.string :operating_system
      t.string :message_type
      t.string :company
      t.string :account_number
      t.string :phone
      t.string :fax
      t.string :billing_address
      t.string :billing_city
      t.string :billing_state
      t.string :billing_zip
      t.string :shipping_address
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zip
      t.string :product_sku
      t.string :product_serial_number
      t.boolean :warranty
      t.date :purchased_on
      t.string :part_number
      t.string :board_location
      t.string :shipping_country
      t.integer :brand_id

      t.timestamps
    end
    add_index :contact_messages, :brand_id
  end
end
