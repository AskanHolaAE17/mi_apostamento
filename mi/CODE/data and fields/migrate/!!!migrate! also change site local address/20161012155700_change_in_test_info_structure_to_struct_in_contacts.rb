class ChangeInTestInfoStructureToStructInContacts < ActiveRecord::Migration
  def change
    rename_column :contacts, :structure_test_info, :struct_test_info    
  end
end

