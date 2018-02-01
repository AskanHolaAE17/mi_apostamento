class CreatePages < ActiveRecord::Migration
  def change
  
    create_table :pages do |t|
    t.string   "page"    
    t.string   "title_tag"
    t.string   "description_meta"
    t.string   "keywords_meta"
    t.string   "em"
            
      t.timestamps                      
    end
  end
end
