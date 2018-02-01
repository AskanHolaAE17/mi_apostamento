class AddLookingForToContacts < ActiveRecord::Migration

  def change
    add_column  :contacts, :looking_for, :text
  end
  
end

