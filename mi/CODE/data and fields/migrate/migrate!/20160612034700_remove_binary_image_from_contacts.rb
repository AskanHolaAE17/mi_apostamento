class RemoveBinaryImageFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :image_data
  end
end
