class AddDefaultToListToUsersMore < ActiveRecord::Migration

  def change
    change_column  :users, :white_writing_able_users_ids_list, :string, default: ' '
  end
  
end

