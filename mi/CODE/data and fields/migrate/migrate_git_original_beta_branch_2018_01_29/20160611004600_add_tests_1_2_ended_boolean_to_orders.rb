class AddTests12EndedBooleanToOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :test_ended
    add_column    :orders, :test_1_ended, :boolean
    add_column    :orders, :test_2_ended, :boolean    
  end
end
