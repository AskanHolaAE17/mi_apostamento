class RemoveAskerFromShowFeedbackRequests < ActiveRecord::Migration
  def change
    remove_column :show_feedback_requests, :asker
  end
end

