class CreateRoomVerballyInfoPages < ActiveRecord::Migration
  def change
    create_table :room_verbally_info_pages do |t|
    
      t.string   :title
      t.text     :msg
      t.string   :translit

      t.timestamps null: false
    end
  end
end


