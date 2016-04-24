class CreateMainPages < ActiveRecord::Migration
  def change
  
    create_table :main_pages do |t|
      t.string   "title"
      t.text     "description"
      t.string   "fond_img_forest_title"
      t.string   "fond_img_forest_alt_text"      
      t.string   "form_name_text"
      t.string   "form_email_text"
      t.string   "text_on_submit_button"      
      t.decimal  "price"
      t.string   "count_of_columns"  
      t.string   "count_of_left_offsets"      
            
      t.timestamps                      
    end
  end
end
