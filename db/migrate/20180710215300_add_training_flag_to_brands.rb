class AddTrainingFlagToBrands < ActiveRecord::Migration[5.1]
  def change
    add_column :brands, :show_on_training_page, :boolean
    Brand.update_all(show_on_training_page: true)
  end
end
