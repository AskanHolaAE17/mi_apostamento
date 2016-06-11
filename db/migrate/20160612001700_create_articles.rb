class CreateArticles < ActiveRecord::Migration
  def change  
  
    create_table :articles do |t|    
      t.string   :title
      t.string   :description
      t.string   :image
      t.string   :code_name
      t.boolean  :able,          default: true
            
      t.timestamps                      
    end
  end
end
