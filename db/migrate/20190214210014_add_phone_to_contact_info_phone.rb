class AddPhoneToContactInfoPhone < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_info_phones, :phone, :string
  end
end
