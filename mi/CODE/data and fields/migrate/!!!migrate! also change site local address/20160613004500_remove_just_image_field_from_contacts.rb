class RemoveJustImageFieldFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :image
  end
end
