class CreateShorturls < ActiveRecord::Migration[5.1]
  def change
    create_table :shorturls do |t|
      t.string :shortcut
      t.string :full_url

      t.timestamps
    end
  end
end
