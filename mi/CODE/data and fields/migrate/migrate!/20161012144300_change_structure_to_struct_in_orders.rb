class ChangeStructureToStructInOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :structure, :struct    
  end
end

