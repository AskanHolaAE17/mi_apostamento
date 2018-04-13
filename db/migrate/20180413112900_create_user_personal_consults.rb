class CreateUserPersonalConsults < ActiveRecord::Migration
  def change
    create_table :user_personal_consults do |t|
      t.belongs_to :user_site, index: true
    
      t.string   :email
      t.string   :name
      t.string   :akey_short      
      
      t.integer  :count_of_consults,   default: 0
      t.string   :story_of_sessions,   default: ''      
                
      t.timestamps                
    end
  end
end
