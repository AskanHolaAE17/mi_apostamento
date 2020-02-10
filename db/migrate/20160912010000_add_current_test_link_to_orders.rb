class AddCurrentTestLinkToOrders < ActiveRecord::Migration

  def change
    add_column  :orders, :current_test_link,  :string
  end
  
end

