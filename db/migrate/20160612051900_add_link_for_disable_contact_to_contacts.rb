class AddLinkForDisableContactToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :link_for_disable_contact, :string
  end
end

