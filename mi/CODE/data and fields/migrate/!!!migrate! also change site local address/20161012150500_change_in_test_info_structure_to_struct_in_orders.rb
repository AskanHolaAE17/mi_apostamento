class ChangeInTestInfoStructureToStructInOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :structure_test_info, :struct_test_info    
  end
end

