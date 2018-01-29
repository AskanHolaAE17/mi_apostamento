class AddRedirectToRoomFlagToContacts < ActiveRecord::Migration

  def change
    add_column  :contacts, :redirect_to_room_flag, :string, default: 'f'
  end
  
end

