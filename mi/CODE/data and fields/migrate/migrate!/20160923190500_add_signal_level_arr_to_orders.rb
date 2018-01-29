class AddSignalLevelArrToOrders < ActiveRecord::Migration

  def change
    add_column  :orders, :signal_level_arr, :string
  end
  
end

