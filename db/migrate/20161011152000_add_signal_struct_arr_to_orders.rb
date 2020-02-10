class AddSignalStructArrToOrders < ActiveRecord::Migration

  def change
    add_column  :orders, :signal_struct_arr, :string
  end
  
end

