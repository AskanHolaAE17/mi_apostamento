class AddStructureToContactsm < ActiveRecord::Migration

  def change
    add_column  :contacts, :structure, :string
  end
  
end

