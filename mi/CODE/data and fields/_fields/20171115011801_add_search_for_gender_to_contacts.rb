class AddSearchForGenderToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :search_for_gender, :string
  end
end

