class AddSentAtToContactMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :contact_messages, :sent_at, :datetime
  end
end
