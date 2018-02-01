class AddImageDataBinaryToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :image_data, :binary
  end
end
