class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
    
      t.string   :members, default: ''      

      t.timestamps null: false
    end
  end
end


