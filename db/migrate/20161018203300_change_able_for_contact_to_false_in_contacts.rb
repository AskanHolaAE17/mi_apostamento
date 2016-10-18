class ChangeAbleForContactToFalseInContacts < ActiveRecord::Migration
  def change
  
    change_column :contacts, :able_for_contact, :boolean, default: false
     
  end
end
