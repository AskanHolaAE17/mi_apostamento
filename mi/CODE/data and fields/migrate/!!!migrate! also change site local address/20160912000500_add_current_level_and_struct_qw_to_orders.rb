class AddCurrentLevelAndStructQwToOrders < ActiveRecord::Migration

  def change
    add_column  :orders, :current_qw_level,  :string
    add_column  :orders, :current_qw_struct, :string    
  end
  
end

