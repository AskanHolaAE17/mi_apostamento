class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer  :id_in_base
      t.string   :email
      t.string   :name
      t.string   :surname      
      t.string   :group
      t.string   :akey
      t.boolean  :active, default: true      
                
      t.timestamps                
    end
  end
end
