class AddSexesToContacts < ActiveRecord::Migration
  def change
  
    add_column :contacts, :own_gender,        :string
    add_column :contacts, :search_for_gender, :string
    
  end
end
