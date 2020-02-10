class AddGenderToOrders < ActiveRecord::Migration

  def change
    add_column  :orders, :gender, :string
  end
  
end

