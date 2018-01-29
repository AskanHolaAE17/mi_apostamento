class AddFlagReadyStrongToContacts < ActiveRecord::Migration

  def change
    add_column  :contacts, :ready_strong, :boolean,   defaulf: false
  end
  
end

