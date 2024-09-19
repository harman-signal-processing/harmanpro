class AddPriorityToBrands < ActiveRecord::Migration[7.1]
  def change
    add_column :brands, :priority, :integer
    
    Brand.find("jbl-professional").update(priority: 0)
    Brand.find("akg").update(priority: 2)
    Brand.find("martin").update(priority: 4)
    Brand.find("amx").update(priority: 6)
    Brand.find("bss").update(priority: 8)
    Brand.find("crown").update(priority: 10)
    Brand.find("soundcraft").update(priority: 12)
    Brand.find("dbx").update(priority: 14)
    Brand.find("lexicon").update(priority: 16)
  end
end
