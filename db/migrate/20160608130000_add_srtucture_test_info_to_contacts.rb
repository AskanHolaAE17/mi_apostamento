class AddSrtuctureTestInfoToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :structure_test_info, :string
  end
end
