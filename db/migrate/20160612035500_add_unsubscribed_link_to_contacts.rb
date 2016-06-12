class AddUnsubscribedLinkToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :unsubscribed_link, :string
  end
end

