class AddFeedbackAbleUsersIdsListToUsers < ActiveRecord::Migration
  def change
    add_column :users, :feedback_able_users_ids_list, :string
  end
end

