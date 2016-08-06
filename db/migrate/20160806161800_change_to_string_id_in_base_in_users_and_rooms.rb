class ChangeToStringIdInBaseInUsersAndRooms < ActiveRecord::Migration
  def change
    change_column :users, :id_in_base, :string
    change_column :rooms, :id_in_base, :string
  end
end

