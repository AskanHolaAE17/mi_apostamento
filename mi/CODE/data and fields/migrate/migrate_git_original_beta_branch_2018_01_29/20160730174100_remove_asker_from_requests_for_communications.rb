class RemoveAskerFromRequestsForCommunications < ActiveRecord::Migration
  def change
    remove_column :requests_for_communications, :asker
  end
end

