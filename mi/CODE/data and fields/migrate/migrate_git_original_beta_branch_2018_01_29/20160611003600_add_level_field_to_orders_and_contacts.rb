class AddLevelFieldToOrdersAndContacts < ActiveRecord::Migration
  def change
    add_column :orders,   :level, :string
    add_column :contacts, :level, :string
  end
end
