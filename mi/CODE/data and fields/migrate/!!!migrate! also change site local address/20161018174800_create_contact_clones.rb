class CreateContactClones < ActiveRecord::Migration
  def change
    create_table :contact_clones do |t|
      t.string   "name"
      t.string   "surname"
      t.string   "city"
      t.string   "country"  
      t.date     "birthday"
      t.string   "about_info"
      t.string   "deep_info"
          
      t.string   "own_gender"      
      t.string   "search_for_gender"
      t.string   "secret_question"
      t.string   "secret_answer_1"
      t.string   "secret_answer_2"
          
      t.integer  "order_number"
      t.string   "email"
      t.string   "group"
      t.boolean  "able_for_contact", default: true             
                
      t.timestamps                
    end
  end
end



