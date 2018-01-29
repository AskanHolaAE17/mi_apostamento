class AddDeepInfoToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :deep_info, :string
  end
end

