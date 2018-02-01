class AddWhiteWritingAbleUsersIdsListToUsers < ActiveRecord::Migration
  def change
    add_column :users, :white_writing_able_users_ids_list, :string
  end
end

