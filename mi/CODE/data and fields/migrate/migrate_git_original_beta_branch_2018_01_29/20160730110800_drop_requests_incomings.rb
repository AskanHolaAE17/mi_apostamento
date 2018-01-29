class DropRequestsIncomings < ActiveRecord::Migration

  def change
    drop_table :requests_incomings
  end

end
