class CreateTseTechnologies < ActiveRecord::Migration[5.1]
  def change
    create_table :tse_technologies do |t|
      t.string :name

      t.timestamps
    end
  end
end
