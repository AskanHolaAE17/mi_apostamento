class RemoveAskerFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :asker
  end
end

