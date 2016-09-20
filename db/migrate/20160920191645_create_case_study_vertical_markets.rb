class CreateCaseStudyVerticalMarkets < ActiveRecord::Migration
  def up
    create_table :case_study_vertical_markets, force: :cascade do |t|
      t.integer :case_study_id
      t.integer :vertical_market_id

      t.timestamps null: false
    end

    CaseStudyVerticalMarket.delete_all

    CaseStudy.all.each do |cs|
      if VerticalMarket.exists?(id: cs.vertical_market_id)
        cs.vertical_markets << VerticalMarket.find(cs.vertical_market_id)
      end
    end

    remove_column :case_studies, :vertical_market_id
  end

  def down
    add_column :case_studies, :vertical_market_id, :integer
    CaseStudyVerticalMarket.all.each do |csvm|
      csvm.case_study.update_attributes(vertical_market_id: csvm.vertical_market_id)
    end
    drop_table :case_study_vertical_markets
  end
end
