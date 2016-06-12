class RemoveUnsubscribedLinkToContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :unsubscribed_link
  end
end

