class AddYesQwsToOrders < ActiveRecord::Migration

  def change
    add_column  :orders, :yes_qws_level,   :string,  default: ' '
    add_column  :orders, :yes_qws_struct,  :string,  default: ' '    
  end
  
end

