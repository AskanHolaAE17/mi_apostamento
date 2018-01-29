class AddAttachmentImageToContacts < ActiveRecord::Migration
  def change
    remove_column  :contacts, :image
    add_attachment :contacts, :image
  end
end
