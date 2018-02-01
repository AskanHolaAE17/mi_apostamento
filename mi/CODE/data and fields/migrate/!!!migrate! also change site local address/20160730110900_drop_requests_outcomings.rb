class DropRequestsOutcomings < ActiveRecord::Migration

  def change
    drop_table :requests_outcomings
  end

end
