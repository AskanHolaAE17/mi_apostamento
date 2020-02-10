class AddLevelTestInfoToOrdersAndContacts < ActiveRecord::Migration
  def change
    add_column :orders,   :level_test_info, :string
    add_column :contacts, :level_test_info, :string
  end
end
