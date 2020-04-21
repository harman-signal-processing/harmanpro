class CreateCaseStudyBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :case_study_brands do |t|
      t.references :case_study, foreign_key: true, type: :integer
      t.references :brand, foreign_key: true, type: :integer
      t.index [:case_study_id, :brand_id], unique: true, name: 'by_case_study_brand'

      t.timestamps
    end  #  create_table :case_study_brands do |t|
    
    # add_index(:case_study_brands, [:case_study_id, :brand_id], unique: true, name: 'by_case_study_brand')
      
  end  #  def change 
  
end  #  class CreateCaseStudyBrands < ActiveRecord::Migration[5.2]
