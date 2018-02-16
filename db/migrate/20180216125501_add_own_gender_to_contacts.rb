class AddOwnGenderToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :own_gender, :string
  end
end

