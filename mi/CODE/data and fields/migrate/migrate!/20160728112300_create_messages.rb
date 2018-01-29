class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer  :user_id
      t.string   :msg_type
      t.string   :sender
      t.string   :title
      t.string   :body      
      t.string   :spam
      t.boolean  :important,        default: false      
      t.boolean  :deleted,          default: false      
      t.boolean  :able,             default: true      
                
      t.timestamps                
    end
  end
end
