class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string   "name"
      t.string   "surname"
      t.string   "city"
      t.string   "country"  
      t.date     "birthday"
      t.string   "about_info"
      t.integer  "order_number"
      t.string   "email"
      t.string   "group"
      t.boolean  "able_for_contact", default: true      
                
      t.timestamps                
    end
  end
end
