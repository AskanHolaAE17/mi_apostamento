class AddStructureToOrders < ActiveRecord::Migration

  def change
    add_column  :orders, :structure, :string
  end
  
end

