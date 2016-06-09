class AddSrtuctureTestInfoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :structure_test_info, :string
  end
end
