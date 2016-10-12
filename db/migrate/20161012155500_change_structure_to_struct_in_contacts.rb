class ChangeStructureToStructInContacts < ActiveRecord::Migration
  def change
    rename_column :contacts, :structure, :struct    
  end
end

