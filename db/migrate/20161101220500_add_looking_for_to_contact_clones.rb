class AddLookingForToContactClones < ActiveRecord::Migration

  def change
    add_column  :contact_clones, :looking_for, :text
  end
  
end

