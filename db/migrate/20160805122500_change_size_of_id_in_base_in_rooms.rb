class ChangeSizeOfIdInBaseInRooms < ActiveRecord::Migration
  def change
    change_column :rooms, :id_in_base, :integer, limit: 8 
  end
end

