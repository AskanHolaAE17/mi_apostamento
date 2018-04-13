class CreateUserSites < ActiveRecord::Migration
  def change
    create_table :user_sites do |t|
      t.string   :email
      t.string   :name
      t.boolean  :active, default: true      
      t.string   :akey_short      
      t.decimal  :common_sum         
                
      t.timestamps                
    end
  end
end
