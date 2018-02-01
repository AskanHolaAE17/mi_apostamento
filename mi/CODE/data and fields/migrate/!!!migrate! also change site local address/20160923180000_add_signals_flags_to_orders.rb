class AddSignalsFlagsToOrders < ActiveRecord::Migration

  def change
    add_column  :orders, :signal_level_done,   :boolean,  default: false
    add_column  :orders, :signal_struct_done,  :boolean,  default: false
  end
  
end

