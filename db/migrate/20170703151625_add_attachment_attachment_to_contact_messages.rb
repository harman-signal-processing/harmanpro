class AddAttachmentAttachmentToContactMessages < ActiveRecord::Migration
  def self.up
    change_table :contact_messages do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :contact_messages, :attachment
  end
end
