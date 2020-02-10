class CreateRoomNonverballyInfoPages < ActiveRecord::Migration
  def change
    create_table :room_nonverbally_info_pages do |t|
    
      t.string   :title
      t.text     :msg
      t.string   :translit

      t.timestamps null: false
    end
  end
end


