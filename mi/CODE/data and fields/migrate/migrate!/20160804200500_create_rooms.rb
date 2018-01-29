class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
    
      t.integer  :user_id
      t.string   :id_in_base
      t.string   :font_size

      t.timestamps null: false
    end
  end
end


